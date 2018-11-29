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
    typealias Work = GetViewerWatchingEpisodesQuery.Data.Viewer.Work.Edge.Node
    typealias PageInfo = GetViewerWatchingEpisodesQuery.Data.Viewer.Work.PageInfo
    
    enum Action {
        case fetch
        case loadMore
    }

    enum Mutation {
        case setWorks([Work])
        case addWorks([Work])
        case setPageInfo(PageInfo)
        case setLoading(Bool)
    }

    struct State {
        var works: [Work] = []
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
            return fetch()
        case .loadMore:
            guard currentState.pageInfo?.hasNextPage == true else { return .empty() }
            guard !currentState.isLoading else { return .empty() }
            return loadMore()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setWorks(let works):
            state.works = works
        case .addWorks(let works):
            state.works += works
        case .setPageInfo(let pageInfo):
            state.pageInfo = pageInfo
        case .setLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
    
    private func fetch() -> Observable<Mutation> {
        let query = GetViewerWatchingEpisodesQuery()
        let fetchEvent = client.rx.fetchMaybe(query: query, cachePolicy: .returnCacheDataAndFetch)
            .asObservable()
            .share(replay: 1)
        
        let works = fetchEvent.map { $0.viewer?.works?.elements }
            .filterNil()
            .map { Mutation.setWorks($0) }
        
        let pageInfo = fetchEvent.map { $0.viewer?.works?.pageInfo }
            .filterNil()
            .map { Mutation.setPageInfo($0) }
        
        return .merge(works, pageInfo)
    }
    
    private func loadMore() -> Observable<Mutation> {
        let endCursor = currentState.pageInfo?.endCursor
        let query = GetViewerWatchingEpisodesQuery(after: endCursor)
        let fetchEvent = client.rx.fetchMaybe(query: query)
            .asObservable()
            .share(replay: 1)
        
        let works = fetchEvent.map { $0.viewer?.works?.elements }
            .filterNil()
            .map { Mutation.addWorks($0) }
        
        let pageInfo = fetchEvent.map { $0.viewer?.works?.pageInfo }
            .filterNil()
            .map { Mutation.setPageInfo($0) }
        
        return .concat(.just(.setLoading(true)),
                       works,
                       pageInfo,
                       .just(.setLoading(false)))
    }
}

extension GetViewerWatchingEpisodesQuery.Data.Viewer.Work {
    var elements: [Edge.Node] {
        guard let edges = edges else { return []}
        return edges.compactMap { $0?.node }
    }
}

extension GetViewerWatchingEpisodesQuery.Data.Viewer.Work.Edge.Node.Episode {
    var elements: [Edge.Node] {
        guard let edges = edges else { return []}
        return edges.compactMap { $0?.node }
    }
}

