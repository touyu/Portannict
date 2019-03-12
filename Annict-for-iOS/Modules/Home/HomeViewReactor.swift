//
//  HomeViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class HomeViewReactor: Reactor {
    typealias Activity = GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.Edge.Node

    enum Action {
        case fetchActivities
    }

    enum Mutation {
        case setActivities([Activity])
    }

    struct State {
        var activities: [Activity] = []
    }
    
    let initialState: HomeViewReactor.State
    let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        initialState = State()
        self.provider = provider
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchActivities:
            return fetchActivities().map { Mutation.setActivities($0) }
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setActivities(let activities):
            state.activities = activities
        }
        return state
    }

    private func fetchActivities() -> Observable<[Activity]> {
        return provider.apiService.fetchFollowingActivities()
            .asObservable()
            .map { $0.viewer?.followingActivities?.values }
            .filterNil()
            .flatMapMany { Observable.just($0) }
    }
}

extension GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity {
    var values: [Edge.Node] {
        return edges?.compactMap { $0?.node } ?? []
    }
}
