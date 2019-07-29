//
//  ActivityRecordTableViewCellReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/25.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class ActivityRecordTableViewCellReactor: Reactor {
    typealias Record = GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.Edge.Node.AsRecord

    enum Action {

    }

    enum Mutation {
        case updateWork(MinimumWork)
    }

    struct State {
        var record: Record
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType, record: Record) {
        self.provider = provider
        initialState = State(record: record)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }

    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let updateWork = provider.workAPIService.event.updateWorkState
            .filter { [weak self] in
                $0.annictId == self?.currentState.record.work.fragments.minimumWork.annictId
            }
            .map { Mutation.updateWork($0) }
        return .merge(mutation, updateWork)
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .updateWork(let work):
            state.record.work.fragments.minimumWork = work
        }
        return state
    }
}
