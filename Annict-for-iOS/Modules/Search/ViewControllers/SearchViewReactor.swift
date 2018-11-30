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
    typealias Work = SearchWorksQuery.Data.SearchWork.Edge.Node

    var initialState: State

    private let client = AnnictGraphQL.client

    init() {
        initialState = State()
    }

    enum Action {
        case fetchWorksOfThisTerm
    }

    enum Mutation {
        case setWorks([Work])
    }

    struct State {
        var works: [Work] = []
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchWorksOfThisTerm:
            return fetch().map { .setWorks($0.elements) }
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setWorks(let works):
            state.works = works
        }
        return state
    }

    private func fetch() -> Observable<SearchWorksQuery.Data.SearchWork> {
        let request = SearchWorksQuery(season: "2018-autumn")
        return client.rx.fetch(query: request, cachePolicy: .returnCacheDataAndFetch).asObservable()
            .map { $0.searchWorks }
            .filterNil()
    }
}

extension SearchWorksQuery.Data.SearchWork {
    var elements: [Edge.Node] {
        guard let edges = edges else { return []}
        return edges.compactMap { $0?.node }
    }
}
