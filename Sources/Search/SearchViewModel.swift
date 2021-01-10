//
//  SearchViewModel.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/10.
//

import SwiftUI
import Combine
import Fluxer

final class SearchViewModel: ViewModel {
    enum Action {
        case fetch(AnnictSeason)
    }

    enum Mutation {
        case setRecomendedWorks([WorkFragment])
        case setAnnictSeason(AnnictSeason)
        case setError(Error)
    }

    class State: ObservableObject {
        @Published var recomendedWorks: [WorkFragment] = []
        @Published var error: Error?
        @Published var annictSeason: AnnictSeason = .current
    }

    @Published var state = State()

    init() {
        initilize()
    }

    func mutate(action: Action) -> AnyPublisher<Mutation, Never> {
        switch action {
        case .fetch(let season):
            let fetchStream = fetch(season: season)
                .map { $0.searchWorks?.edges?.compactMap { $0?.node?.fragments.workFragment } ?? []  }
                .map { Mutation.setRecomendedWorks($0) }
                .catch { Just(.setError($0)) }
                .assertNoFailure()

            let setSeasonStream = Just(Mutation.setAnnictSeason(season))

            return fetchStream
                .merge(with: setSeasonStream)
                .eraseToAnyPublisher()
        }
    }

    func reduce(mutation: Mutation) {
        switch mutation {
        case .setRecomendedWorks(let works):
            state.recomendedWorks = works
        case .setAnnictSeason(let season):
            state.annictSeason = season
        case .setError(let error):
            state.error = error
        }
    }

    private func fetch(season: AnnictSeason) -> AnyPublisher<SearchWorksBySeasonQuery.Data, Error> {
        let query = SearchWorksBySeasonQuery(first: 100, after: nil, seasons: [season.id])
        return Network.shared.apollo.fetch(query: query)
    }
}

