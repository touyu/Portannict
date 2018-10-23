//
//  RootViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit

final class RootViewReactor: Reactor {
    var initialState: RootViewReactor.State

    init() {
        initialState = State(loginState: .logout)
    }

    enum Action {

    }

    enum Mutation {

    }

    struct State {
        var loginState: LoginState
    }

    enum LoginState {
        case logout
        case login
    }
}
