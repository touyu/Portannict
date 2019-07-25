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
        case updateWork(MinimumWork)
    }

    struct State {
        var pageInfo: PageInfoFrag?
        var isLoading: Bool = false
        var items: [HomeSectionItem] = []
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

    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let updateWork = provider.workAPIService.event.updateWorkState
            .map { Mutation.updateWork($0) }
        return .merge(mutation, updateWork)
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setActivities(let activities):
            state.items = activities.compactMap { convertSectionItem(activity: $0) }
        case .appendActivities(let activities):
            state.items += activities.compactMap { convertSectionItem(activity: $0) }
        case .setPageInfo(let pageInfo):
            state.pageInfo = pageInfo
        case .setLoading(let isLoading):
            state.isLoading = isLoading
        case .updateWork(let work):
//            guard let index = currentState.activities.firstIndex(where: { $0.work?.id == work.id }) else { return state }
//            state.activities[index].work = work
            break
        }
        return state
    }

    private func fetchActivities(after: String? = nil, cachePolicy: CachePolicy) -> Observable<GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity> {
        return provider.apiService.fetchFollowingActivities(after: after, cachePolicy: cachePolicy)
            .map { $0.viewer?.followingActivities }
            .filterNil()
    }

    func reactorForWork(index: Int) -> WorkViewReactor? {
        guard let work = currentState.items[index].work else { return nil }
        return .init(provider: provider, work: work)
    }

    private func convertSectionItem(activity: Activity) -> HomeSectionItem? {
        switch activity.itemType {
        case .record(let record):
            return .record(.init(provider: provider, record: record))
        case .status(let status):
            return .status(.init(provider: provider, status: status))
        case .multipleRecord(let record):
            return .multiRecord(.init(provider: provider, multipleRecord: record))
        case .review(let review):
            return .review
        default:
            return nil
        }
    }
}

extension GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity {
    var values: [Edge.Node] {
        return edges?.compactMap { $0?.node } ?? []
    }
}

enum HomeSectionItem: Equatable {
    case record(ActivityRecordTableViewCellReactor)
    case status(ActivityStatusTableViewCellReactor)
    case multiRecord(ActivityMultipleRecordTableViewCellReactor)
    case review

    var work: MinimumWork? {
        switch self {
        case .record(let reactor):
            return reactor.currentState.record.work.fragments.minimumWork
        case .status(let reactor):
            return reactor.currentState.status.work.fragments.minimumWork
        case .multiRecord(let reactor):
            return reactor.currentState.multipleRecord.work.fragments.minimumWork
        default:
            return nil
        }
    }

    static func == (lhs: HomeSectionItem, rhs: HomeSectionItem) -> Bool {
        switch (lhs, rhs) {
        case (.record(let reactor1), .record(let reactor2)):
            return reactor1.currentState.record.resultMap == reactor2.currentState.record.resultMap
        case (.status(let reactor1), .status(let reactor2)):
            return reactor1.currentState.status.resultMap == reactor2.currentState.status.resultMap
        case (.multiRecord(let reactor1), .multiRecord(let reactor2)):
            return reactor1.currentState.multipleRecord.resultMap == reactor2.currentState.multipleRecord.resultMap
        case (.review, .review):
            return true
        default:
            return false
        }
    }
}
