//
//  SearchViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/30.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class SearchViewReactor: Reactor {
    typealias PageInfo = SearchWorksQuery.Data.SearchWork.PageInfo
    
    enum Action {
        case fetchWorksForThisTerm
        case fetchMore
    }

    enum Mutation {
        case setWorks([MinimumWork])
        case appendWorks([MinimumWork])
        case setPageInfo(PageInfo)
    }

    struct State {
        var season: Season = .current
        var works: [MinimumWork] = []
        var pageInfo: PageInfo?
    }
    
    let initialState: State
    private let provider: ServiceProviderType
    private let client = AnnictGraphQL.client
    
    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchWorksForThisTerm:
            let stream = fetch().share(replay: 1)
            let setWorks = stream.map { Mutation.setWorks($0.minimumWorks) }
            let setPageInfo = stream.map { Mutation.setPageInfo($0.pageInfo) }
            return .merge(setWorks, setPageInfo)
        case .fetchMore:
            guard let pageInfo = currentState.pageInfo else { return .empty() }
            guard pageInfo.hasNextPage else { return .empty() }
            
            let stream = fetch(after: currentState.pageInfo?.endCursor).share(replay: 1)
            let setWorks = stream.map { Mutation.appendWorks($0.minimumWorks) }
            let setPageInfo = stream.map { Mutation.setPageInfo($0.pageInfo) }
            return .merge(setWorks, setPageInfo)
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setWorks(let works):
            state.works = works
        case .setPageInfo(let pageInfo):
            state.pageInfo = pageInfo
        case .appendWorks(let works):
            state.works += works
        }
        return state
    }
    
    func reactorForResult() -> SearchResultViewReactor {
        return .init(provider: provider)
    }
    
    func reactorForWork(index: Int) -> WorkViewReactor {
        return .init(provider: provider, work: currentState.works[index])
    }

    private func fetch(after: String? = nil) -> Observable<SearchWorksQuery.Data.SearchWork> {
        let request = SearchWorksQuery(season: currentState.season.value, after: after)
        return client.rx.fetchMaybe(query: request, cachePolicy: .returnCacheDataAndFetch).asObservable()
            .map { $0.searchWorks }
            .filterNil()
    }
}

extension SearchWorksQuery.Data.SearchWork: Connection {
    var minimumWorks: [MinimumWork] {
        return values.map { $0.fragments.minimumWork }
    }
}
