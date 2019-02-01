//
//  WorkViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/12/01.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class WorkViewReactor: Reactor {
    enum Action {

    }

    enum Mutation {

    }

    struct State {
        var work: MinimumWork
        var heroID: String
    }
    
    var initialState: State
    
    init(work: MinimumWork, heroID: String) {
        initialState = State(work: work, heroID: heroID)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
