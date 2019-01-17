//
//  WatchingWorksViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/01/16.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileWorksViewReactor: Reactor {
    typealias Work = GetViewerWorksQuery.Data.Viewer.Work.Node
    typealias PageInfo = GetViewerWorksQuery.Data.Viewer.Work.PageInfo
    
    enum Action {
        case fetch
        case loadMore
    }

    enum Mutation {
        case setWorks([Work])
        case addWorks([Work])
        case setPageInfo(PageInfo)
    }

    struct State {
        var works: [Work] = []
        var pageInfo: PageInfo?
    }
    
    var initialState: State
    var statusState: StatusState
    
    init(statusState: StatusState) {
        initialState = State()
        self.statusState = statusState
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetch:
            let fetchWorksEvent = fetchWorks().share()
            let works = fetchWorksEvent.map { Mutation.setWorks($0.values) }
            let pageInfo = fetchWorksEvent.map { Mutation.setPageInfo($0.pageInfo) }
            return .merge(works, pageInfo)
        case .loadMore:
            guard currentState.pageInfo?.hasNextPage ?? false else { return .empty() }
            let fetchWorksEvent = fetchWorks(after: currentState.pageInfo?.endCursor).share()
            let works = fetchWorksEvent.map { Mutation.addWorks($0.values) }
            let pageInfo = fetchWorksEvent.map { Mutation.setPageInfo($0.pageInfo) }
            return .merge(works, pageInfo)
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
        }
        return state
    }
    
    private func fetchWorks(after: String? = nil) -> Observable<GetViewerWorksQuery.Data.Viewer.Work> {
        let query = GetViewerWorksQuery(state: statusState, after: after)
        return AnnictGraphQL.client.rx.fetch(query: query, cachePolicy: .returnCacheDataAndFetch)
            .map { $0.viewer?.works }
            .filterNil()
    }
}
