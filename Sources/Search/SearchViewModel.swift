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
        case search(String)
        case clearSearchResults
    }

    enum Mutation {
        case setSearchResultsWorks([WorkFragment])
        case setError(Error)
    }

    class State: ObservableObject {
        @Published var searchResultWorks: [WorkFragment] = []
        @Published var error: Error?
    }

    @Published var state = State()
    @Published var searchText : String = ""

    init() {
        initilize()
    }

    func transform(action: AnyPublisher<Action, Never>) -> AnyPublisher<Action, Never> {
        let searchTextStream = $searchText
            .map { Action.search($0) }

        return action
            .merge(with: searchTextStream)
            .eraseToAnyPublisher()
    }

    func mutate(action: Action) -> AnyPublisher<Mutation, Never> {
        switch action {
        case .search(let title):
            guard !title.isEmpty else { return Just(.setSearchResultsWorks([])).eraseToAnyPublisher() }
            let searchStream = search(title: title)
                .map { $0.searchWorks?.edges?.compactMap { $0?.node?.fragments.workFragment } ?? []  }
                .map { Mutation.setSearchResultsWorks($0) }
                .catch { Just(.setError($0)) }
                .assertNoFailure()

            return searchStream
                .eraseToAnyPublisher()
        case .clearSearchResults:
            return Just(.setSearchResultsWorks([]))
                .eraseToAnyPublisher()
        }
    }

    func reduce(mutation: Mutation) {
        switch mutation {
        case .setSearchResultsWorks(let works):
            state.searchResultWorks = works
        case .setError(let error):
            state.error = error
        }
    }

    private func search(title: String) -> AnyPublisher<SearchWorksByTitlesQuery.Data, Error> {
        let query = SearchWorksByTitlesQuery(first: 100, after: nil, titles: [title])
        return Network.shared.apollo.fetch(query: query)
    }
}
