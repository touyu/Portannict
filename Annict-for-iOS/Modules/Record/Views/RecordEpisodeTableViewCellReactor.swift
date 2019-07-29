//
//  RecordEpisodeTableViewCellReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/21.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class RecordEpisodeTableViewCellReactor: Reactor {
    typealias Work = GetViewerWatchingEpisodesQuery.Data.Viewer.Work.Node
    
    enum Action {

    }

    enum Mutation {
        case incrementEpisode(String)
    }

    struct State {
        var work: Work
    }
    
    let initialState: State
    let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, work: Work) {
        self.provider = provider
        initialState = State(work: work)
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let willCreateRecord = provider.episodeAPIService.event.willCreateRecordEpisodeID
            .map { Mutation.incrementEpisode($0) }
        return .merge(mutation, willCreateRecord)
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .incrementEpisode(let episodeID):
            guard let index = state.work.episodes?.values.firstIndex(where: { $0.fragments.minimumEpisode.id == episodeID }) else { return state }
            state.work.episodes?.nodes?[index]?.fragments.minimumEpisode.viewerDidTrack = true
            state.work.episodes?.nodes?[index]?.fragments.minimumEpisode.viewerRecordsCount += 1
        }
        return state
    }
}

extension RecordEpisodeTableViewCellReactor: Equatable {
    static func == (lhs: RecordEpisodeTableViewCellReactor, rhs: RecordEpisodeTableViewCellReactor) -> Bool {
        return lhs.currentState.work.resultMap == rhs.currentState.work.resultMap
    }
}
