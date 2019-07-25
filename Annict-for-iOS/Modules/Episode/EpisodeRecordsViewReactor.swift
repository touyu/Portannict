//
//  EpisodeRecordsViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/25.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class EpisodeRecordsViewReactor: Reactor {
    enum Action {
        case fetchRecords
    }

    enum Mutation {
        case setRecords([MinimumRecord])
    }

    struct State {
        let episode: MinimumEpisode
        var records: [MinimumRecord] = []
        
        init(episode: MinimumEpisode) {
            self.episode = episode
        }
    }

    let initialState: State

    init(episode: MinimumEpisode) {
        initialState = State(episode: episode)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchRecords:
            return fetchRecords().map { Mutation.setRecords($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setRecords(let records):
            state.records = records
        }
        return state
    }
    
    private func fetchRecords() -> Observable<[MinimumRecord]> {
        let query = GetEpisodeRecordsQuery(episodeID: currentState.episode.annictId)
        return AnnictGraphQL.client.rx.fetch(query: query, cachePolicy: .fetchIgnoringCacheData)
            .map { $0.searchEpisodes?.values.first }
            .filterNil()
            .map { $0.records?.values }
            .filterNil()
            .mapMany { $0.fragments.minimumRecord }
    }
}

extension GetEpisodeRecordsQuery.Data.SearchEpisode: Connection {}
extension GetEpisodeRecordsQuery.Data.SearchEpisode.Node.Record: Connection {}
