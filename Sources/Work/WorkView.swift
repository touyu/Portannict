//
//  WorkView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/30.
//

import SwiftUI
import KingfisherSwiftUI
import Apollo
import SwiftUIX
import ComposableArchitecture

extension SearchWorkEpisodesQuery.Data.SearchWork.Node.Episode: Equatable { }

struct WorkState: Equatable {
    let workID: Int
    var work: WorkFragment?
    var episodesState: WorkEpisodesState?
    var reviewsState: WorkReviewsState?
    var actionSheet: ActionSheetState<WorkAction>?
}

enum WorkAction: Equatable {
    case fetch
    case statusButtonTapped
    case actionSheetDismissed
    case updateStatus(StatusState)

    case setWork(Result<WorkFragment, APIError>)

    case episodes(WorkEpisodesAction)
    case reviews(WorkReviewsAction)
}

struct WorkEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let workReducer = Reducer<WorkState, WorkAction, WorkEnvironment>
    .combine(
        workEpisodesReducer
            .optional()
            .pullback(state: \.episodesState,
                      action: /WorkAction.episodes,
                      environment: { WorkEpisodesEnvironment(
                        mainQueue: $0.mainQueue,
                        fetch: EpisodeService.fetch
                      )}),
        workReviewsReducer
            .optional()
            .pullback(state: \.reviewsState,
                      action: /WorkAction.reviews,
                      environment: { WorkReviewsEnvironment(
                        mainQueue: $0.mainQueue,
                        fetch: ReviewService.fetch
                      )}),
        Reducer { state, action, env in
            struct RequestId: Hashable {}

            func fetch() -> Effect<WorkFragment, APIError> {
                return APIClient.shared.fetchEffect(query: SearchWorksByIdQuery(annictId: state.workID))
                    .compactMap { $0.searchWorks?.nodes?.first??.fragments.workFragment }
                    .eraseToEffect()
            }

            func updateStatus(statusState: StatusState) -> Effect<WorkFragment, APIError> {
                guard let id = state.work?.id else { return .none }
                return APIClient.shared.performEffect(mutation: UpdateStatusMutation(workId: id, state: statusState))
                    .compactMap { $0.updateStatus?.work?.fragments.workFragment }
                    .eraseToEffect()
            }

            switch action {
            case .fetch:
                let fetchStream = fetch()
                    .receive(on: env.mainQueue)
                    .catchToEffect()
                    .map(WorkAction.setWork)

                return fetchStream
                    .eraseToEffect()
                    .cancellable(id: RequestId())
            case .updateStatus(let status):
                state.work?.viewerStatusState = status
                return updateStatus(statusState: status)
                    .catchToEffect()
                    .map(WorkAction.setWork)
                    .cancellable(id: RequestId())
            case .statusButtonTapped:
                state.actionSheet = .init(
                    title: TextState("ステータスを変更"),
                    buttons: [
                        .default(TextState("選択解除"), send: .updateStatus(.noState)),
                        .default(TextState("見たい"), send: .updateStatus(.wannaWatch)),
                        .default(TextState("見てる"), send: .updateStatus(.watching)),
                        .default(TextState("見た"), send: .updateStatus(.watched)),
                        .default(TextState("一時中断"), send: .updateStatus(.onHold)),
                        .default(TextState("視聴中止"), send: .updateStatus(.stopWatching)),
                        .cancel(),
                    ]
                )
                return .none
            case .actionSheetDismissed:
                state.actionSheet = nil
                return .none
            case .setWork(.success(let work)):
                state.work = work
                state.episodesState = WorkEpisodesState(work: work)
                state.reviewsState = WorkReviewsState(work: work)
                return .none
            case .setWork(.failure(let error)):
                return .none
            case .episodes:
                return .none
            case .reviews:
                return .none
            }

        }
    )

struct WorkView: View {
    let store: Store<WorkState, WorkAction>

    private let black = Color(hex: 0x222222)

    var body: some View {
        GeometryReader { geometry in
            WithViewStore(store) { viewStore in
                ScrollView(.vertical, showsIndicators: false) {
                    if let work = viewStore.work {
                        VStack(alignment: .leading, spacing: 24) {
                            WorkHeaderView(work: work)
                                .frame(width: geometry.size.width, height: geometry.size.width * 1.4, alignment: .center)
                            StatusButton(state: work.viewerStatusState ?? .noState) {
                                viewStore.send(.statusButtonTapped)
                            }
                            .frame(height: 44)
                            .padding(.init(top: 0, leading: 16, bottom: 16, trailing: 16))
                            .actionSheet(
                                store.scope(state: { $0.actionSheet }),
                                dismiss: .actionSheetDismissed
                            )
                            Group {
                                if work.episodesCount > 0 {
                                    IfLetStore(store.scope(state: \.episodesState,
                                                           action: WorkAction.episodes),
                                                           then: WorkEpisodesView.init(store:))
                                }
                                if work.reviewsCount > 0 {
                                    IfLetStore(store.scope(state: \.reviewsState,
                                                           action: WorkAction.reviews),
                                                           then: WorkReviewsView.init(store:))
                                }
                            }
                            .padding(.init(top: 0, leading: 16, bottom: 48, trailing: 16))
                        }
                    }
                }
                .onAppear {
                    viewStore.send(.fetch)
                }
            }
            .background(.systemBackground)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkView(store: Store(initialState: WorkState(workID: 865),
                              reducer: workReducer,
                              environment: WorkEnvironment(
                                mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                              )
                )
        )
    }
}

extension EpisodeFragment: Identifiable, Hashable {
    public func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}
