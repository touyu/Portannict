//
//  HomeViewModel.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/24.
//

import Foundation
import Combine
import Fluxer
import Apollo

final class HomeViewModel: ViewModel {
    typealias Activity = GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.Edge.Node
    typealias PageInfo = GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.PageInfo

    enum Action {
        case fetch
        case fetchMore
        case updateWork(GraphQLID, StatusState)
    }

    enum Mutation {
        case setActivities([Activity])
        case appendActivities([Activity])
        case insertActivities([Activity])
        case setPageInfo(PageInfo?)
        case updateWork(WorkFragment)
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
        case .updateWork(let id, let state):
            let updateStream = updateStatus(id: id, state: state)
                .map { Mutation.updateWork($0) }

//            let fetchStream = fetch()
//                .map { $0.viewer?.followingActivities?.edges?.compactMap { $0?.node } ?? [] }
//                .map { Mutation.insertActivities($0) }
//
//            let totalStream = updateStream
//                .append(fetchStream)

            return updateStream
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
        case .insertActivities(let newActivities):
            print(newActivities)
            var activities = state.activities
            activities.insert(contentsOf: newActivities, at: 0)
            activities.uniquified()
            state.activities = activities
        case .setPageInfo(let pageInfo):
            state.pageInfo = pageInfo
        case .updateWork(let work):
            guard let index = state.activities.firstIndex(where: { $0.work?.id == work.id } ) else { return }
            state.activities[index].work = work
            print(work)
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

    private func updateStatus(id: GraphQLID, state: StatusState) -> AnyPublisher<WorkFragment, Error> {
        let mutation = UpdateStatusMutation(workId: id, state: state)
        return Network.shared.apollo.perform(mutation: mutation)
            .map { $0.updateStatus?.work?.fragments.workFragment }
            .tryFilter { $0 != nil }
            .map { $0! }
            .eraseToAnyPublisher()
    }
}

extension Array where Element: Equatable {
    func uniquify() -> [Element] {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }

    mutating func uniquified() {
        self = self.uniquify()
    }
}

extension GraphQLSelectionSet {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return (lhs.resultMap as NSDictionary).isEqual(to: (rhs.resultMap as [AnyHashable : Any]))
    }
}

extension Array where Element: GraphQLSelectionSet {
    func uniquify() -> [Element] {
        return reduce([]) { n1, n2 in
            n1.contains(where: { $0 == n2 }) ? n1 : n1 + [n2]
        }
    }

    mutating func uniquified() {
        self = self.uniquify()
    }
}
