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
    var accessToken: String? = UserDefaults.standard.string(forKey: "accessToken")
}

enum RootAction: Equatable {
    case login(LoginAction)
}

struct RootEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
    var saveToken: ((String) -> Void)
}

let rootReducer = Reducer<RootState, RootAction, RootEnvironment>.combine(
    loginReducer.pullback(state: \.loginState,
                          action: /RootAction.login,
                          environment: { LoginEnvironment(mainQueue: $0.mainQueue) }),
    Reducer { state, action, env in
        switch action {
        case .login(let loginAction):
            switch loginAction {
            case .setAccessToken(.success(let token)):
                state.accessToken = token
                env.saveToken(token)
                return .none
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
                RootTabView()
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
                                saveToken: { _ in }
                              )))
    }
}
