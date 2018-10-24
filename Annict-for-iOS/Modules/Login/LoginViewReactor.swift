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
    let initialState: State
    let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.initialState = State(loginSuccess: false,
                             error: nil)
        self.provider = provider
    }

    enum Action {
        case login(String)
    }

    enum Mutation {
        case changeLoginSuccess(Bool)
        case setError(Error)
    }

    struct State {
        var loginSuccess: Bool
        var error: Error?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .login(let code):
            return provider.apiService.getOauthToken(code: code)
                .asObservable()
                .do(onNext: { [weak self] res in
                    self?.provider.userDefaultsService.save(value: res.accessToken, forKey: .accessToken)
                })
                .map { _ in .changeLoginSuccess(true) }
                .catchError { .just(.setError($0)) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .changeLoginSuccess(let value):
            state.loginSuccess = value
        case .setError(let error):
            state.error = error
        }
        return state
    }
}
