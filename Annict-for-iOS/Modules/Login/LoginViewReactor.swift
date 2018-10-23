//
//  LoginViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class LoginViewReactor: Reactor {
    var initialState: LoginViewReactor.State

    init() {
        initialState = State()
    }

    enum Action {

    }

    enum Mutation {

    }

    struct State {

    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
