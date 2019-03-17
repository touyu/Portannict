//
//  HomeViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift
import Apollo

final class HomeViewReactor: Reactor {
    typealias Activity = GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.Edge.Node

    enum Action {
        case fetchActivities
        case loadMore
        case forceFetch
    }

    enum Mutation {
        case setActivities([Activity])
        case appendActivities([Activity])
        case setPageInfo(PageInfoFrag)
        case setLoading(Bool)
    }

    struct State {
        var activities: [Activity] = []
        var pageInfo: PageInfoFrag?
        var isLoading: Bool = false
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
            let startLoading = Observable<Mutation>.just(.setLoading(true))
            let fetchActivitiesEvent = fetchActivities(cachePolicy: .returnCacheDataAndFetch).share()
            let setActivitiesEvent = fetchActivitiesEvent.map { Mutation.setActivities($0.values) }
            let setPageInfoEvent = fetchActivitiesEvent.map { Mutation.setPageInfo($0.pageInfo.fragments.pageInfoFrag) }
            let endLoading = Observable<Mutation>.just(.setLoading(false))
            return .concat(startLoading, setActivitiesEvent, setPageInfoEvent, endLoading)
        case .loadMore:
            guard !currentState.isLoading else { return .empty() }
            guard let pageInfo = currentState.pageInfo, pageInfo.hasNextPage else { return .empty() }
            let startLoading = Observable<Mutation>.just(.setLoading(true))
            let fetchActivitiesEvent = fetchActivities(after: currentState.pageInfo?.endCursor, cachePolicy: .returnCacheDataElseFetch).share()
            let appendActivitiesEvent = fetchActivitiesEvent.map { Mutation.appendActivities($0.values) }
            let setPageInfoEvent = fetchActivitiesEvent.map { Mutation.setPageInfo($0.pageInfo.fragments.pageInfoFrag) }
            let endLoading = Observable<Mutation>.just(.setLoading(false))
            return .concat(startLoading, appendActivitiesEvent, setPageInfoEvent, endLoading)
        case .forceFetch:
            let startLoading = Observable<Mutation>.just(.setLoading(true))
            let fetchActivitiesEvent = fetchActivities(cachePolicy: .fetchIgnoringCacheData).share()
            let setActivitiesEvent = fetchActivitiesEvent.map { Mutation.setActivities($0.values) }
            let setPageInfoEvent = fetchActivitiesEvent.map { Mutation.setPageInfo($0.pageInfo.fragments.pageInfoFrag) }
            let endLoading = Observable<Mutation>.just(.setLoading(false))
            return .concat(startLoading, setActivitiesEvent, setPageInfoEvent, endLoading)
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setActivities(let activities):
            state.activities = activities
        case .appendActivities(let activities):
            state.activities += activities
        case .setPageInfo(let pageInfo):
            state.pageInfo = pageInfo
        case .setLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }

    private func fetchActivities(after: String? = nil, cachePolicy: CachePolicy) -> Observable<GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity> {
        return provider.apiService.fetchFollowingActivities(after: after, cachePolicy: cachePolicy)
            .map { $0.viewer?.followingActivities }
            .filterNil()
    }
}

extension GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity {
    var values: [Edge.Node] {
        return edges?.compactMap { $0?.node } ?? []
    }
}
