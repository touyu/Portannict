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
    enum Presentation: View, Identifiable, Hashable {
        case episode(EpisodeFragment)

        var body: some View {
            switch self {
            case .episode(let episode):
                EpisodeView(episode: episode)
            }
        }
    }


    var work: WorkFragment
    var episodes: [EpisodeFragment] = []
    var pageInfo: PageInfoFragment?
    var isEpisodesLoading: Bool = false
    var presentation: Presentation?
}

enum WorkEpisodesAction: Equatable {
    case fetch
    case fetchMore
    case episodeCellTapped(Int)
    case episodeDismissed
    case setIsEpisodesLoading(Bool)

    case setEpisodes(Result<SearchWorkEpisodesQuery.Data.SearchWork.Node.Episode, APIError>)
    case appendEpisodes(Result<SearchWorkEpisodesQuery.Data.SearchWork.Node.Episode, APIError>)
}

struct WorkEpisodesEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let workEpisodesReducer = Reducer<WorkEpisodesState, WorkEpisodesAction, WorkEpisodesEnvironment> { state, action, env in
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
        return fetchEpisodes()
            .receive(on: env.mainQueue)
            .catchToEffect()
            .map(WorkEpisodesAction.setEpisodes)
            .cancellable(id: RequestId())
    case .fetchMore:
        let loading = Effect<WorkEpisodesAction, Never>(value: .setIsEpisodesLoading(true))
        let fetchMoreStream = fetchMoreEpisodes()
            .receive(on: env.mainQueue)
            .catchToEffect()
            .map(WorkEpisodesAction.appendEpisodes)
        let finished = Effect<WorkEpisodesAction, Never>(value: .setIsEpisodesLoading(false))
        return Effect.concatenate(loading, fetchMoreStream, finished)
    case .setEpisodes(.success(let episodes)):
        state.episodes = episodes.edges?.compactMap { $0?.node?.fragments.episodeFragment } ?? []
        state.pageInfo = episodes.pageInfo.fragments.pageInfoFragment
        return .none
    case .episodeCellTapped(let index):
        state.presentation = .episode(state.episodes[index])
        return .none
    case .episodeDismissed:
        state.presentation = nil
        return .none
    case .setIsEpisodesLoading(let isLoading):
        state.isEpisodesLoading = isLoading
        return .none
    case .setEpisodes(.failure(let error)):
        return .none
    case .appendEpisodes(.success(let episodes)):
        state.episodes += episodes.edges?.compactMap { $0?.node?.fragments.episodeFragment } ?? []
        state.pageInfo = episodes.pageInfo.fragments.pageInfoFragment
        return .none
    case .appendEpisodes(.failure(let error)):
        return .none
    }
}

struct WorkEpisodesView: View {
    let store: Store<WorkEpisodesState, WorkEpisodesAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            LazyVStack(alignment: .leading, spacing: 20) {
                Text("Episodes \(viewStore.work.episodesCount)")
                    .font(.title2)
                    .fontWeight(.bold)
                ForEach(viewStore.episodes.indices, id: \.self) { index in
                    let episode = viewStore.episodes[index]
                    Button(action: {
                        viewStore.send(.episodeCellTapped(index))
                    }, label: {
                        WorkEpisodeCell(episode: episode)
                            .foregroundColor(.primary)
                    })
                    .sheet(item: viewStore.binding(
                            get: \.presentation,
                            send: { _ in .episodeDismissed } )
                    ) { $0 }
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
