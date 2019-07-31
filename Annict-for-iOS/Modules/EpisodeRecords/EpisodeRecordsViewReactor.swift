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
        case block(Int)
    }

    enum Mutation {
        case setRecords([MinimumRecord])
        case appendRecord(MinimumRecord)
        case block(Int)
    }

    struct State {
        let episode: MinimumEpisode
        var records: [MinimumRecord] = []
        
        init(episode: MinimumEpisode) {
            self.episode = episode
        }
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType, episode: MinimumEpisode) {
        self.provider = provider
        initialState = State(episode: episode)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchRecords:
            return fetchRecords().map { Mutation.setRecords($0) }
        case .block(let userID):
            return .just(.block(userID))
        }
    }

    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let createdRecord = provider.episodeAPIService.event.didCreatedRecord
            .map { Mutation.appendRecord($0) }
        return .merge(mutation, createdRecord)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setRecords(let records):
            state.records = records
        case .appendRecord(let record):
            state.records.insert(record, at: 0)
        case .block(let userID):
            state.records = state.records.filter { $0.user.fragments.minimumUser.annictId != userID }
        }
        return state
    }

    func reactorForPostRecord() -> PostRecordViewReactor {
        return .init(provider: provider, episode: currentState.episode)
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
