//
//  WorkEpisodesView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/03/08.
//

import SwiftUI
import ComposableArchitecture
import SwiftUIX

struct WorkEpisodesState: Equatable {
    var work: WorkFragment
    var episodeCellStates: [WorkEpisodeCellState] = []
    var pageInfo: PageInfoFragment?
    var isEpisodesLoading: Bool = false
}

enum WorkEpisodesAction: Equatable {
    case fetch
    case fetchMore
    case setIsEpisodesLoading(Bool)

    case setEpisodes(Result<SearchWorkEpisodesQuery.Data.SearchWork.Node.Episode, APIError>)
    case appendEpisodes(Result<SearchWorkEpisodesQuery.Data.SearchWork.Node.Episode, APIError>)

    case episodeCell(index: Int, action: WorkEpisodeCellAction)
}

struct WorkEpisodesEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let workEpisodesReducer = Reducer<WorkEpisodesState, WorkEpisodesAction, WorkEpisodesEnvironment>.combine(
    workEpisodeCellReducer.forEach(state: \.episodeCellStates,
                                   action: /WorkEpisodesAction.episodeCell(index:action:),
                                   environment: { _ in  WorkEpisodeCellEnvironment() }),
    Reducer { state, action, env in
        struct RequestId: Hashable {}

        func fetchEpisodes() -> Effect<SearchWorkEpisodesQuery.Data.SearchWork.Node.Episode, APIError> {
            return APIClient.shared.fetchEffect(query: SearchWorkEpisodesQuery(workAnnictId: state.work.annictId, first: 5))
                .compactMap { $0.searchWorks?.nodes?.first??.episodes }
                .eraseToEffect()
        }

        func fetchMoreEpisodes() -> Effect<SearchWorkEpisodesQuery.Data.SearchWork.Node.Episode, APIError> {
            guard let pageInfo = state.pageInfo else { return .none }
            guard pageInfo.hasNextPage else { return .none }
            return APIClient.shared.fetchEffect(query: SearchWorkEpisodesQuery(workAnnictId: state.work.annictId,
                                                                               first: 30,
                                                                               after: pageInfo.endCursor))
                .compactMap { $0.searchWorks?.nodes?.first??.episodes }
                .eraseToEffect()
        }

        switch action {
        case .fetch:
            let loading = Effect<WorkEpisodesAction, Never>(value: .setIsEpisodesLoading(true))
            let fetchStream = fetchEpisodes()
                .receive(on: env.mainQueue)
                .catchToEffect()
                .map(WorkEpisodesAction.setEpisodes)
                .cancellable(id: RequestId())
            let finished = Effect<WorkEpisodesAction, Never>(value: .setIsEpisodesLoading(false))
            return Effect.concatenate(loading, fetchStream, finished)
        case .fetchMore:
            let loading = Effect<WorkEpisodesAction, Never>(value: .setIsEpisodesLoading(true))
            let fetchMoreStream = fetchMoreEpisodes()
                .receive(on: env.mainQueue)
                .catchToEffect()
                .map(WorkEpisodesAction.appendEpisodes)
            let finished = Effect<WorkEpisodesAction, Never>(value: .setIsEpisodesLoading(false))
            return Effect.concatenate(loading, fetchMoreStream, finished)
        case .setIsEpisodesLoading(let isLoading):
            state.isEpisodesLoading = isLoading
            return .none
        case .setEpisodes(.success(let episodes)):
            state.episodeCellStates = episodes.edges?
                .compactMap { $0?.node?.fragments.episodeFragment }
                .map { WorkEpisodeCellState(episode: $0) } ?? []
            state.pageInfo = episodes.pageInfo.fragments.pageInfoFragment
            return .none
        case .setEpisodes(.failure(let error)):
            return .none
        case .appendEpisodes(.success(let episodes)):
            state.episodeCellStates += episodes.edges?
                .compactMap { $0?.node?.fragments.episodeFragment }
                .map { WorkEpisodeCellState(episode: $0) } ?? []
            state.pageInfo = episodes.pageInfo.fragments.pageInfoFragment
            return .none
        case .appendEpisodes(.failure(let error)):
            return .none
        case .episodeCell:
            return .none
        }
    }
)

struct WorkEpisodesView: View {
    let store: Store<WorkEpisodesState, WorkEpisodesAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            LazyVStack(alignment: .leading, spacing: 20) {
                Text("Episodes \(viewStore.work.episodesCount)")
                    .font(.title2)
                    .fontWeight(.bold)
                ForEachStore(
                    store.scope(state: \.episodeCellStates, action: WorkEpisodesAction.episodeCell(index:action:))
                ) { cellStore in
                    WorkEpisodeCell(store: cellStore)
                }
                if let pageInfo = viewStore.pageInfo, pageInfo.hasNextPage == true {
                    HStack {
                        Spacer()
                        if viewStore.isEpisodesLoading {
                            ActivityIndicator()
                                .animated(true)
                                .style(.medium)
                                .frame(height: 40)

                        } else {
                            WorkMoreButton {
                                viewStore.send(.fetchMore)
                            }
                        }
                        Spacer()
                    }
                }
            }
            .onAppear {
                viewStore.send(.fetch)
            }
        }
    }
}

struct WorkEpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        WorkEpisodesView(store: Store(initialState: WorkEpisodesState(work: .dummy),
                                      reducer: workEpisodesReducer,
                                      environment: WorkEpisodesEnvironment(
                                        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                                      )
        )
        )
    }
}
