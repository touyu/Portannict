//
//  LoginViewModel.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/24.
//

import Fluxer
import SwiftUI
import Combine
import AuthenticationServices

final class LoginViewModel: NSObject, ViewModel {
    enum Action {
        case login
    }

    enum Mutation {
        case setAccessToken(String)
        case setError(Error)
    }

    class State: ObservableObject {
        @Published var accessToken: String?
        @Published var error: Error?
    }

    enum E: Error {
        case invalidURL
    }

    @Published var state = State()

    override init() {
        super.init()

        initilize()
    }

    func mutate(action: Action) -> AnyPublisher<Mutation, Never> {
        switch action {
        case .login:
            return startWebAuthentication()
                .flatMap { [weak self] code in self?.login(code: code) ?? Empty().eraseToAnyPublisher() }
                .map { Mutation.setAccessToken($0.accessToken) }
                .catch { Just(Mutation.setError($0)) }
                .assertNoFailure()
                .eraseToAnyPublisher()
        }
    }

    func reduce(mutation: Mutation) {
        switch mutation {
        case .setAccessToken(let token):
            state.accessToken = token
        case .setError(let error):
            state.error = error
        }
    }

    private func login(code: String) -> AnyPublisher<OauthTokenResponse, Error> {
        let request = OauthTokenRequest(code: code)
        return HTTPClient.send(request: request)
    }

    private func startWebAuthentication() -> Future<String, Error> {
        return Future<String, Error> { resolve in
            let session = ASWebAuthenticationSession(url: Constants.oauthURL, callbackURLScheme: Constants.callbackURLScheme) { url, error in
                if let error = error {
                    return resolve(.failure(error))
                }
                guard let url = url else {
                    return resolve(.failure(E.invalidURL))
                }
                let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                guard let code = components?.queryItems?.first?.value else {
                    return resolve(.failure(E.invalidURL))
                }

                return resolve(.success(code))
            }
            session.presentationContextProvider = self
            session.start()
        }
    }
}

extension LoginViewModel: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
