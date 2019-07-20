//
//  RecordViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class RecordViewReactor: Reactor {
    typealias Work = GetViewerWatchingEpisodesQuery.Data.Viewer.Work.Node
    typealias PageInfo = GetViewerWatchingEpisodesQuery.Data.Viewer.Work.PageInfo
    
    enum Action {
        case fetch
        case loadMore
    }

    enum Mutation {
        case setWorks([Work])
        case appendWorks([Work])
        case setPageInfo(PageInfo)
        case setLoading(Bool)
    }

    struct State {
        var cellReactors: [RecordEpisodeTableViewCellReactor] = []
        var pageInfo: PageInfo?
        var isLoading: Bool = false
    }
    
    var initialState: State
    
    private var client = AnnictGraphQL.client
    
    init() {
        initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetch:
            let stream = fetch().share(replay: 1)
            let setWorks = stream.map { Mutation.setWorks($0.values) }
            let setPageInfo = stream.map { Mutation.setPageInfo($0.pageInfo) }
            
            return .concat(.just(.setLoading(true)),
                           setWorks,
                           setPageInfo,
                           .just(.setLoading(false)))
        case .loadMore:
            guard let pageInfo = currentState.pageInfo else { return .empty() }
            guard pageInfo.hasNextPage else { return .empty() }
            guard !currentState.isLoading else { return .empty() }
            
            let stream = fetch(after: pageInfo.endCursor).share(replay: 1)
            let setWorks = stream.map { Mutation.appendWorks($0.values) }
            let setPageInfo = stream.map { Mutation.setPageInfo($0.pageInfo) }
            
            return .concat(.just(.setLoading(true)),
                           setWorks,
                           setPageInfo,
                           .just(.setLoading(false)))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setWorks(let works):
            state.cellReactors = works.map(RecordEpisodeTableViewCellReactor.init)
        case .appendWorks(let works):
            state.cellReactors += works.map(RecordEpisodeTableViewCellReactor.init)
        case .setPageInfo(let pageInfo):
            state.pageInfo = pageInfo
        case .setLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
    
    private func fetch(after: String? = nil) -> Observable<GetViewerWatchingEpisodesQuery.Data.Viewer.Work> {
        let query = GetViewerWatchingEpisodesQuery(first: 6, after: after)
        return client.rx.fetchMaybe(query: query, cachePolicy: .fetchIgnoringCacheData)
            .map { $0.viewer?.works }
            .asObservable()
            .filterNil()
    }
}

extension GetViewerWatchingEpisodesQuery.Data.Viewer.Work: Connection {}
extension GetViewerWatchingEpisodesQuery.Data.Viewer.Work.Node.Episode: Connection {}

