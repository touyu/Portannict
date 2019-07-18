//
//  WorkViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/12/01.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class WorkViewReactor: Reactor {
    enum Action {
        case fetchEpisodes
    }
    
    enum Mutation {
        case setEpisodes([MinimumEpisode])
    }
    
    struct State {
        let work: MinimumWork
        var episodes: [MinimumEpisode] = []
        
        init(work: MinimumWork) {
            self.work = work
        }
    }
    
    var initialState: State
    
    init(work: MinimumWork) {
        initialState = State(work: work)
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
        let query = SearchWorksByIdQuery(annictId: currentState.work.annictId)
        return AnnictGraphQL.client.rx.fetchMaybe(query: query, cachePolicy: .returnCacheDataAndFetch)
            .asObservable()
            .map { $0.searchWorks?.values.first?.episodes?.values.map { $0.fragments.minimumEpisode } }
            .filterNil()
    }
}

extension SearchWorksByIdQuery.Data.SearchWork: Connection {}
extension SearchWorksByIdQuery.Data.SearchWork.Node.Episode: Connection {}

