//
//  RootViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit

final class RootViewReactor: Reactor {
    let initialState: State
    let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.initialState = State(loginState: .logout)
        self.provider = provider
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
    
    func reactorForLogin() -> LoginViewReactor {
        return LoginViewReactor(provider: provider)
    }
    
    func reactorForHome() -> HomeViewReactor {
        return HomeViewReactor()
    }
}
