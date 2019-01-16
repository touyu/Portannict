//
//  WatchingWorksViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/01/16.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileWorksViewReactor: Reactor {
    enum Action {

    }

    enum Mutation {

    }

    struct State {

    }
    
    var initialState: State
    var statusState: StatusState
    
    init(statusState: StatusState) {
        initialState = State()
        self.statusState = statusState
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
