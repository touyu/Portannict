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
    typealias PageInfo = GetViewerWorksQuery.Data.Viewer.Work.PageInfo
    
    enum Action {
        case fetch
        case loadMore
    }

    enum Mutation {
        case setWorks([MinimumWork])
        case addWorks([MinimumWork])
        case setPageInfo(PageInfo)
    }

    struct State {
        var works: [MinimumWork] = []
        var pageInfo: PageInfo?
    }
    
    let initialState: State
    let statusState: StatusState
    let provider: ServiceProviderType
    
    init(statusState: StatusState) {
        initialState = State()
        self.statusState = statusState
        self.provider = ServiceProvider()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetch:
            let fetchWorksEvent = fetchWorks().share()
            let works = fetchWorksEvent.map { Mutation.setWorks($0.minimumWorks) }
            let pageInfo = fetchWorksEvent.map { Mutation.setPageInfo($0.pageInfo) }
            return .merge(works, pageInfo)
        case .loadMore:
            guard currentState.pageInfo?.hasNextPage ?? false else { return .empty() }
            let fetchWorksEvent = fetchWorks(after: currentState.pageInfo?.endCursor).share()
            let works = fetchWorksEvent.map { Mutation.addWorks($0.minimumWorks) }
            let pageInfo = fetchWorksEvent.map { Mutation.setPageInfo($0.pageInfo) }
            return .merge(works, pageInfo)
        }
    }

    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
//        let updateState = provider.workAPIService.event.updateWorkState
//            .filter { $0.viewerStatusState !=  }
//            .map { [weak self] work in
//                let works = self?.currentState.works.filter { $0.id != work.id }
//            }
        return .merge(mutation)
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

    func reactorForWork(index: Int) -> WorkViewReactor {
        return .init(provider: provider, work: currentState.works[index])
    }

    private func fetchWorks(after: String? = nil) -> Observable<GetViewerWorksQuery.Data.Viewer.Work> {
        let query = GetViewerWorksQuery(state: statusState, after: after)
        return AnnictGraphQL.client.rx.fetchMaybe(query: query, cachePolicy: .returnCacheDataAndFetch)
            .asObservable()
            .map { $0.viewer?.works }
            .filterNil()
    }
}

extension GetViewerWorksQuery.Data.Viewer.Work {
    var minimumWorks: [MinimumWork] {
        return values.map { $0.fragments.minimumWork }
    }
}
