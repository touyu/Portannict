//
//  RootViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class RootViewReactor: Reactor {
    enum Action {
        
    }
    
    enum Mutation {
        case setLoginState(LoginState)
    }
    
    struct State {
        var loginState: LoginState
    }
    
    enum LoginState {
        case logout
        case login
    }
    
    let initialState: State
    let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        let token = provider.userDefaultsService.fetch(forKey: .accessToken, type: String.self)
        if let token = token, !token.isEmpty {
            self.initialState = State(loginState: .login)
        } else {
            self.initialState = State(loginState: .logout)
        }
        self.provider = provider
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let loginEvent = provider.userDefaultsService.event.accessToken
            .filterNil()
            .map { _ in Mutation.setLoginState(.login) }
        
        return Observable.of(mutation, loginEvent).merge()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setLoginState(let loginState):
            state.loginState = loginState
        }
        return state
    }
    
    func reactorForLogin() -> LoginViewReactor {
        return LoginViewReactor(provider: provider)
    }
    
    func reactorForHome() -> HomeViewReactor {
        return HomeViewReactor()
    }
}
