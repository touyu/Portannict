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
        initialState = State(oauthToken: nil,
                             loginSuccess: false,
                             error: nil)
    }

    enum Action {
        case fetchOauthToken(String)
        case login(String)
    }

    enum Mutation {
        case setOauthToken(String)
        case changeLoginSuccess(Bool)
        case setError(Error)
    }

    struct State {
        var oauthToken: String?
        var loginSuccess: Bool
        var error: Error?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchOauthToken(let code):
            return getOauthToken(code: code)
                .asObservable()
                .map { Mutation.setOauthToken($0.accessToken) }
                .catchError { .just(.setError($0)) }
            
        case .login(let accessToken):
            UserDefaultsRepository.save(value: accessToken, forKey: .accessToken)
            return .just(.changeLoginSuccess(true))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setOauthToken(let token):
            state.oauthToken = token
        case .changeLoginSuccess(let value):
            state.loginSuccess = value
        case .setError(let error):
            state.error = error
        }
        return state
    }
    
    private func getOauthToken(code: String) -> Single<OauthTokenRequest.Response> {
        let request = OauthTokenRequest(code: code)
        return HTTPClient.send(request: request)
    }
}
