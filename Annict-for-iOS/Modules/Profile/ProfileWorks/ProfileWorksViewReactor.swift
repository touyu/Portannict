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
        case insertWork(MinimumWork)
        case removeWork(String)
    }

    struct State {
        var works: [MinimumWork] = []
        var pageInfo: PageInfo?
    }
    
    let initialState: State
    let statusState: StatusState
    let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, statusState: StatusState) {
        initialState = State()
        self.statusState = statusState
        self.provider = provider
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
        let currentStatusState = statusState
        
        let filterWorks = provider.workAPIService.event.updateWorkState
            .filter { $0.viewerStatusState != currentStatusState }
            .map { Mutation.removeWork($0.id) }
            .do(onNext: { _ in
                print("OOOOOOOOOOOOO!!!!!!!!!!")
            })
        
        let appendWork = provider.workAPIService.event.updateWorkState
            .filter { $0.viewerStatusState == currentStatusState }
            .map { Mutation.insertWork($0) }
            .do(onNext: { _ in
                print("HHHHHHHHHHHHHH!!!!!!!!!!")
            })
        
        return .merge(mutation, filterWorks, appendWork)
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
        case .insertWork(let work):
            state.works.insert(work, at: 0)
        case .removeWork(let id):
            state.works.removeAll(where: { $0.id == id })
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
