//
//  ActivityMultipleRecordTableViewCellReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/25.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class ActivityMultipleRecordTableViewCellReactor: Reactor {
    typealias MultipleRecord = GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.Edge.Node.AsMultipleRecord

    enum Action {

    }

    enum Mutation {
        case updateWork(MinimumWork)
    }

    struct State {
        var multipleRecord: MultipleRecord
    }

    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType, multipleRecord: MultipleRecord) {
        self.provider = provider
        initialState = State(multipleRecord: multipleRecord)
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let updateWork = provider.workAPIService.event.updateWorkState
            .filter { [weak self] in
                $0.annictId == self?.currentState.multipleRecord.work.fragments.minimumWork.annictId
            }
            .map { Mutation.updateWork($0) }
        return .merge(mutation, updateWork)
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .updateWork(let work):
            state.multipleRecord.work.fragments.minimumWork = work
        }
        return state
    }
}
