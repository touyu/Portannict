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

extension GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.Edge.Node: Equatable {}
extension GetFollowingActivitiesQuery.Data: Equatable {}
extension GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.PageInfo: Equatable {}

struct HomeState: Equatable {
    typealias Activity = GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.Edge.Node
    typealias PageInfo = GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.PageInfo

    var activities: [Activity] = []
    var pageInfo: PageInfo?
    var error: NetworkError?
}

enum HomeAction: Equatable {
    case fetch
    case fetchMore
    case updateWork

    case setActivities(Result<GetFollowingActivitiesQuery.Data, NetworkError>)
    case appendActivities(Result<GetFollowingActivitiesQuery.Data, NetworkError>)
}

struct HomeEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let homeReducer = Reducer<HomeState, HomeAction, HomeEnvironment> { state, action, environment in
    struct RequestId: Hashable {}

    switch action {
    case .fetch:
        let query = GetFollowingActivitiesQuery(first: 30, after: nil)
        return Network.shared.apollo.fetch2(query: query)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(HomeAction.setActivities)
            .cancellable(id: RequestId())
    case .fetchMore:
        guard let pageInfo = state.pageInfo else { return .none }
        guard pageInfo.hasNextPage else { return .none }
        let query = GetFollowingActivitiesQuery(first: 30, after: pageInfo.endCursor)
        return Network.shared.apollo.fetch2(query: query)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(HomeAction.appendActivities)
            .cancellable(id: RequestId())
    case .updateWork:
        return .none
    case .setActivities(.success(let data)):
        let activities = data.viewer?.followingActivities?.edges?.compactMap { $0?.node } ?? []
        state.activities = activities
        state.pageInfo = data.viewer?.followingActivities?.pageInfo
        return .none
    case .setActivities(.failure(let error)):
        state.error = error
        return .none
    case .appendActivities(.success(let data)):
        let activities = data.viewer?.followingActivities?.edges?.compactMap { $0?.node } ?? []
        state.activities.append(contentsOf: activities)
        return .none
    case .appendActivities(.failure(let error)):
        state.error = error
        return .none
    }
}

struct HomeView: View {
    let store: Store<HomeState, HomeAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                ScrollView {
                    if viewStore.activities.isEmpty {
                        VStack {
                            ForEach(0..<10) { i in
                                ActivityEmptyView()
                                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            }
                        }
                    }

                    LazyVStack(spacing: 20) {
                        ForEach(viewStore.activities.indices, id: \.self) { index in
                            activityItemView(viewStore: viewStore, index: index)
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
            }
        }
    }

    func activityItemView(viewStore: ViewStore<HomeState, HomeAction>, index: Int) -> some View {
        Group {
            let activity = viewStore.binding(get: { $0.activities[index] }, send: { _ in HomeAction.updateWork })
            if let _ = activity.wrappedValue.asRecord {
                ActivityRecordView(record: activity.map(\.asRecord!.fragments.recordFragment))
                    .onSelectState { state in
//                        viewModel.action.send(.updateWork(record.work.fragments.workFragment.id, state))
                    }
            } else if let _ = activity.wrappedValue.asReview {
                ActivityReviewView(review: activity.map(\.asReview!.fragments.reviewFragment))
            } else if let _ = activity.wrappedValue.asStatus {
                ActivityStatusView(status: activity.map(\.asStatus!.fragments.statusFragment))
            } else {
                EmptyView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(initialState: HomeState(),
                          reducer: homeReducer,
                          environment: HomeEnvironment(
                            mainQueue: DispatchQueue.main.eraseToAnyScheduler()
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

