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
    enum Action {
        
    }

    enum Mutation {
        
    }

    struct State {
        
    }
    
    var initialState: State
    
    private let client = AnnictGraphQL.client
    
    init() {
        initialState = State()
    }
    
    var cellReactors: [SeasonWorksCollectionViewCellReactor] = {
        return RecommendSeasonSection.allCases.map { .init(section: $0) }
    }()

    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        return state
    }

    private func fetch() -> Observable<SearchWorksQuery.Data.SearchWork> {
        let request = SearchWorksQuery(season: "2018-autumn")
        return client.rx.fetch(query: request, cachePolicy: .returnCacheDataAndFetch).asObservable()
            .map { $0.searchWorks }
            .filterNil()
    }
}
