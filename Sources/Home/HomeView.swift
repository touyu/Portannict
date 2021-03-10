//
//  HomeView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/11.
//

import SwiftUI
import SwiftUIX
import SkeletonUI
import Apollo
import ComposableArchitecture

extension GetFollowingActivitiesQuery.Data: Equatable {}
extension PageInfoFragment: Equatable {}
extension ActivityItemFragment: Equatable {}

struct HomeState: Equatable {
    enum Presentation: Identifiable, Hashable {
        case work
        case episode
    }
    
    var activityStates: [ActivityState] = []
    var pageInfo: PageInfoFragment?
    var error: APIError?
    var presentation: Presentation?
    var workState: WorkState?
}

enum HomeAction: Equatable {
    case fetch
    case fetchMore
    case updateWork

    case setActivities(Result<GetFollowingActivitiesQuery.Data, APIError>)
    case appendActivities(Result<GetFollowingActivitiesQuery.Data, APIError>)
    case setPresentation(HomeState.Presentation?)

    case activityCell(index: Int, action: ActivityAction)
    case work(WorkAction)
}

struct HomeEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var service: ServiceType
}

let homeReducer = Reducer<HomeState, HomeAction, HomeEnvironment>
    .combine(
        activityReducer
            .forEach(state: \.activityStates,
                     action: /HomeAction.activityCell(index:action:),
                     environment: { _ in ActivityEnvironment( )}),
        workReducer
            .optional()
            .pullback(state: \.workState,
                      action: /HomeAction.work,
                      environment: { WorkEnvironment(
                        mainQueue: $0.mainQueue
                      )}),
        Reducer { state, action, environment in
            struct RequestId: Hashable {}

            switch action {
            case .fetch:
                return environment.service.fetchHomeActivities(first: 30, after: nil)
                    .receive(on: environment.mainQueue)
                    .catchToEffect()
                    .map(HomeAction.setActivities)
                    .cancellable(id: RequestId())
            case .fetchMore:
                guard let pageInfo = state.pageInfo, pageInfo.hasNextPage else { return .none }
                return environment.service.fetchHomeActivities(first: 30, after: pageInfo.endCursor)
                    .receive(on: environment.mainQueue)
                    .catchToEffect()
                    .map(HomeAction.appendActivities)
                    .cancellable(id: RequestId())
            case .updateWork:
                return .none
            case .setActivities(.success(let data)):
                let activities = data.viewer?.followingActivities?.edges?.compactMap { $0?.node?.fragments.activityItemFragment } ?? []
                state.activityStates = activities.map(ActivityState.init)
                state.pageInfo = data.viewer?.followingActivities?.pageInfo.fragments.pageInfoFragment
                return .none
            case .setActivities(.failure(let error)):
                state.error = error
                return .none
            case .appendActivities(.success(let data)):
                let activities = data.viewer?.followingActivities?.edges?.compactMap { $0?.node?.fragments.activityItemFragment } ?? []
                state.activityStates.append(contentsOf: activities.map(ActivityState.init))
                state.pageInfo = data.viewer?.followingActivities?.pageInfo.fragments.pageInfoFragment
                return .none
            case .appendActivities(.failure(let error)):
                state.error = error
                return .none
            case .setPresentation(let p):
                state.presentation = p
                return .none
            case .activityCell(index: let index, action: let activityAction):
                switch activityAction {
                case .workTapped:
                    if let workID = state.activityStates[index].item.work?.annictId {
                        state.workState = WorkState(workID: workID)
                        state.presentation = .work
                    }
                    return .none
                default:
                    return .none
                }
            case .work:
                return .none
            }
        }
    )

struct HomeView: View {
    let store: Store<HomeState, HomeAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                ScrollView {
                    if viewStore.activityStates.isEmpty {
                        VStack {
                            ForEach(0..<10) { i in
                                ActivityEmptyView()
                                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            }
                        }
                    }

                    LazyVStack(spacing: 20) {
                        ForEachStore(
                            store.scope(state: \.activityStates, action: HomeAction.activityCell(index:action:))
                        ) { childStore in
                            ActivityView(store: childStore)
                        }
                        ActivityIndicator()
                            .animated(true)
                            .style(.medium)
                            .frame(height: 80)
                            .onAppear {
                                viewStore.send(.fetchMore)
                            }
                    }
                    .padding(EdgeInsets(top: 24, leading: 16, bottom: 0, trailing: 16))
                }
                .navigationBarTitle("Home")
                .onAppear {
                    viewStore.send(.fetch)
                }
                .sheet(item: viewStore.binding(
                    get: \.presentation,
                    send: HomeAction.setPresentation
                )) { _ in
                    IfLetStore(
                        store.scope(state: \.workState,
                                    action: HomeAction.work),
                        then: WorkView.init(store:)
                    )
                }
            }
        }
    }

    //    func activityItemView(viewStore: ViewStore<HomeState, HomeAction>, index: Int) -> some View {
    //        Group {
    //            let activity = viewStore.binding(get: { $0.activities[index] }, send: { _ in HomeAction.updateWork })
    //            if let _ = activity.wrappedValue.asRecord {
    //                ActivityRecordView(record: activity.map(\.asRecord!.fragments.recordFragment))
    //                //                    .onSelectState { state in
    //                //                        viewModel.action.send(.updateWork(record.work.fragments.workFragment.id, state))
    //                //                    }
    //            } else if let _ = activity.wrappedValue.asReview {
    //                ActivityReviewView(review: activity.map(\.asReview!.fragments.reviewFragment))
    //            } else if let _ = activity.wrappedValue.asStatus {
    //                ActivityStatusView(status: activity.map(\.asStatus!.fragments.statusFragment))
    //            } else {
    //                EmptyView()
    //            }
    //        }
    //    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(initialState: HomeState(),
                          reducer: homeReducer,
                          environment: HomeEnvironment(
                            mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                            service: PreviewService()
                          )

        )
        HomeView(store: store)
    }
}

extension GraphQLSelectionSet {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return (lhs.resultMap as NSDictionary).isEqual(to: (rhs.resultMap as [AnyHashable : Any]))
    }
}

extension Array where Element: GraphQLSelectionSet {
    func uniquify() -> [Element] {
        return reduce([]) { n1, n2 in
            n1.contains(where: { $0 == n2 }) ? n1 : n1 + [n2]
        }
    }

    mutating func uniquified() {
        self = self.uniquify()
    }
}

