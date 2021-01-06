//
//  HomeViewModel.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/24.
//

import Foundation
import Combine
import Fluxer

final class HomeViewModel: ViewModel {
    typealias Activity = GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.Edge.Node
    typealias PageInfo = GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.PageInfo

    enum Action {
        case fetch
        case fetchMore
    }

    enum Mutation {
        case setActivities([Activity])
        case appendActivities([Activity])
        case setPageInfo(PageInfo?)
        case setError(Error)
    }

    class State: ObservableObject {
        @Published var activities: [Activity] = []
        @Published var error: Error?

        var pageInfo: PageInfo?
    }

    @Published var state: State = State()

    init() {
        initilize()
    }

    func mutate(action: Action) -> AnyPublisher<Mutation, Never> {
        switch action {
        case .fetch:
            let fetchStream = fetch().share()

            let setActivitiesStream = fetchStream
                .map { Mutation.setActivities($0.viewer?.followingActivities?.edges?.compactMap { $0?.node } ?? []) }

            let setPageInfoStream = fetchStream
                .map { Mutation.setPageInfo($0.viewer?.followingActivities?.pageInfo) }

            return setActivitiesStream
                .merge(with: setPageInfoStream)
                .catch { Just(Mutation.setError($0)) }
                .assertNoFailure()
                .eraseToAnyPublisher()
        case .fetchMore:
            let fetchStream = fetchMore().share()

            let appendActivitiesStream = fetchStream
                .map { Mutation.appendActivities($0.viewer?.followingActivities?.edges?.compactMap { $0?.node } ?? []) }

            let setPageInfoStream = fetchStream
                .map { Mutation.setPageInfo($0.viewer?.followingActivities?.pageInfo) }

            return appendActivitiesStream
                .merge(with: setPageInfoStream)
                .catch { Just(Mutation.setError($0)) }
                .assertNoFailure()
                .eraseToAnyPublisher()
        }
    }

    func reduce(mutation: Mutation) {
        switch mutation {
        case .setActivities(let activities):
            state.activities = activities
        case .appendActivities(let activities):
            state.activities.append(contentsOf: activities)
        case .setPageInfo(let pageInfo):
            state.pageInfo = pageInfo
        case .setError(let error):
            state.error = error
        }
    }

    private func fetch() -> AnyPublisher<GetFollowingActivitiesQuery.Data, Error> {
        let query = GetFollowingActivitiesQuery(first: 30, after: nil)
        return Network.shared.apollo.fetch(query: query)
    }

    private func fetchMore() -> AnyPublisher<GetFollowingActivitiesQuery.Data, Error> {
        guard let pageInfo = state.pageInfo else { return Empty().eraseToAnyPublisher() }
        guard pageInfo.hasNextPage else { return Empty().eraseToAnyPublisher() }
        let query = GetFollowingActivitiesQuery(first: 30, after: pageInfo.endCursor)
        return Network.shared.apollo.fetch(query: query)
    }
}
