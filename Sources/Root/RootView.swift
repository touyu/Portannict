//
//  RootView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/20.
//

import SwiftUI
import ComposableArchitecture

struct RootState: Equatable {
    var loginState = LoginState()
    var rootTabState = RootTabState()
    var accessToken: String? = UserDefaults.standard.string(forKey: "accessToken")
}

enum RootAction: Equatable {
    case logout

    case login(LoginAction)
    case rootTab(RootTabAction)
}

struct RootEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
    var saveToken: ((String?) -> Void)
    var clearCache: (() -> Void)
}

let rootReducer = Reducer<RootState, RootAction, RootEnvironment>.combine(
    loginReducer.pullback(state: \.loginState,
                          action: /RootAction.login,
                          environment: { LoginEnvironment(mainQueue: $0.mainQueue) }),
    rootTabReducer.pullback(state: \.rootTabState,
                            action: /RootAction.rootTab,
                            environment: { RootTabEnvironment(mainQueue: $0.mainQueue) }),
    Reducer { state, action, env in
        switch action {
        case .logout:
            env.saveToken(nil)
            env.clearCache()
            state = .init()
            return .none
        case .login(let loginAction):
            switch loginAction {
            case .setAccessToken(.success(let token)):
                state.accessToken = token
                env.saveToken(token)
                return .none
            default:
                return .none
            }
        case .rootTab(let rootTabAction):
            switch rootTabAction {
            case .profile(let profileAction):
                switch profileAction {
                case .setting(let settingAction):
                    switch settingAction {
                    case .logout:
                        return Effect(value: .logout)
                    }
                default:
                    return .none
                }
            default:
                return .none
            }
        }
    }
)

struct RootView: View {
    let store: Store<RootState, RootAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            if viewStore.accessToken == nil {
                LoginView(store: store.scope(state: \.loginState,
                                             action: RootAction.login))
            } else {
                RootTabView(store: store.scope(state: \.rootTabState,
                                               action: RootAction.rootTab))
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: Store(initialState: RootState(),
                              reducer: rootReducer,
                              environment: RootEnvironment(
                                mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                                saveToken: { _ in },
                                clearCache: {}
                              )))
    }
}
