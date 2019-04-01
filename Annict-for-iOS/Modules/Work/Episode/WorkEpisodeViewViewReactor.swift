//
//  WorkEpisodeViewViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/04/02.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class WorkEpisodeViewViewReactor: Reactor {
    enum Action {
        case fetchEpisodes
    }

    enum Mutation {
        case setEpisodes([MinimumEpisode])
    }

    struct State {
        let annictId: Int
        
        var episodes: [MinimumEpisode] = []
        
        init(annictId: Int) {
            self.annictId = annictId
        }
    }
    
    var initialState: State
    
    init(annictId: Int) {
        initialState = State(annictId: annictId)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchEpisodes:
            return fetchEpisodes().map { .setEpisodes($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setEpisodes(let episodes):
            state.episodes = episodes
        }
        return state
    }

    private func fetchEpisodes() -> Observable<[MinimumEpisode]> {
        let query = SearchWorksByIdQuery(annictId: currentState.annictId)
        return AnnictGraphQL.client.rx.fetchMaybe(query: query, cachePolicy: .returnCacheDataAndFetch)
            .asObservable()
            .map { $0.searchWorks?.values.first?.episodes?.values.map { $0.fragments.minimumEpisode } }
            .filterNil()
    }
}

extension SearchWorksByIdQuery.Data.SearchWork: Connection {}
extension SearchWorksByIdQuery.Data.SearchWork.Node.Episode: Connection {}
