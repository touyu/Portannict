//
//  LoginView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/03/09.
//

import SwiftUI
import ComposableArchitecture
import Combine
import AuthenticationServices

final class ASWebAuthenticationSessionManager: Equatable {
    enum E: Error {
        case invalidURL
    }

    let authCode = PassthroughSubject<String, Error>()
    private let id = UUID()
    private var webAuthenticationSession: ASWebAuthenticationSession?
    private let presentationContextProvider = AuthPresentationContextProvider()

    init() {
        NotificationCenter.default.addObserver(forName: .init(rawValue: "URLSchema"), object: nil, queue: nil) { [weak self] notification in
            self?.webAuthenticationSession?.cancel()
            guard let url = notification.object as? URL else { return }
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            guard let code = components?.queryItems?.first?.value else {
                self?.authCode.send(completion: .failure(E.invalidURL))
                return
            }
            self?.authCode.send(code)
        }
    }

    static func == (lhs: ASWebAuthenticationSessionManager, rhs: ASWebAuthenticationSessionManager) -> Bool {
        return lhs.id == rhs.id
    }

    func startWebAuthentication() -> AnyPublisher<String, Error> {
        let session = ASWebAuthenticationSession(url: Constants.oauthURL, callbackURLScheme: Constants.callbackURLScheme) { [weak self] url, error in
            if let error = error {
                self?.authCode.send(completion: .failure(error))
                return
            }
            guard let url = url else {
                self?.authCode.send(completion: .failure(E.invalidURL))
                return
            }
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            guard let code = components?.queryItems?.first?.value else {
                self?.authCode.send(completion: .failure(E.invalidURL))
                return
            }

            self?.authCode.send(code)
        }
        session.presentationContextProvider = presentationContextProvider
        session.prefersEphemeralWebBrowserSession = true
        session.start()
        webAuthenticationSession = session
        return authCode.eraseToAnyPublisher()
    }
}

final class AuthPresentationContextProvider: NSObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}

struct LoginState: Equatable {
    var sessionManager = ASWebAuthenticationSessionManager()
    var accessToken: String?
}

enum LoginAction: Equatable {
    case loginButtonTapped
    case setAccessToken(Result<String, NSError>)
}

struct LoginEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
}

let loginReducer = Reducer<LoginState, LoginAction, LoginEnvironment> { state, action, env in
    struct RequestId: Hashable {}

    func login(code: String) -> AnyPublisher<OauthTokenResponse, Error> {
        let request = OauthTokenRequest(code: code)
        return HTTPClient.send(request: request)
    }

    switch action {
    case .loginButtonTapped:
        return state.sessionManager.startWebAuthentication()
            .flatMap(login)
            .receive(on: env.mainQueue)
            .map(\.accessToken)
            .mapError { $0 as NSError }
            .catchToEffect()
            .map(LoginAction.setAccessToken)
    case .setAccessToken(.success(let token)):
        print(token)
        state.accessToken = token
        return .none
    case .setAccessToken(.failure(let error)):
        print(error)
        return .none
    }
}

struct LoginView: View {
    let store: Store<LoginState, LoginAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                MonochromeImage("killlakill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

                Rectangle()
                    .fill(Color.black)
                    .opacity(0.7)

                VStack(spacing: 160) {
                    Text("Portannict")
                        .font(.system(size: 62, weight: .black))
                        .foregroundColor(Color(hex: 0xF85B73))
                        .kerning(1.4)
                    Button(action: {
                        viewStore.send(.loginButtonTapped)
                    }, label: {
                        Text("ログイン")
                            .font(.system(size: 18), weight: .bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    })
                    .frame(width: 180, height: 44)
                    .background(Color.white)
                    .clipShape(Capsule())
                }
            }
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(store: Store(initialState: LoginState(),
                               reducer: loginReducer,
                               environment: LoginEnvironment(
                                mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                               ))
        )
    }
}
