//
//  SeasonWorksCollectionViewCellReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/01/18.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class SeasonWorksCollectionViewCellReactor: Reactor {
    typealias Work = SearchWorksQuery.Data.SearchWork.Node
    
    enum Action {
        case fetch
    }

    enum Mutation {
        case setWorks([Work])
    }

    struct State {
        var section: RecommendSeasonSection
        var works: [Work] = []
        
        init(section: RecommendSeasonSection) {
            self.section = section
        }
    }
    
    var initialState: State
    
    init(section: RecommendSeasonSection) {
        initialState = State(section: section)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetch:
            return fetch().map { .setWorks($0.values) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setWorks(let works):
            state.works = works.filter { $0.image?.twitterAvatarUrl != nil }
        }
        return state
    }

    private func fetch() -> Observable<SearchWorksQuery.Data.SearchWork> {
        let request = SearchWorksQuery(season: currentState.section.season.value)
        return AnnictGraphQL.client.rx.fetch(query: request, cachePolicy: .returnCacheDataAndFetch).asObservable()
            .map { $0.searchWorks }
            .filterNil()
    }
}

extension SearchWorksQuery.Data.SearchWork: Connection { }
