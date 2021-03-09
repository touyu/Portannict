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
}

enum RootAction: Equatable {
    case login(LoginAction)
}

struct RootEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
}

let rootReducer = Reducer<RootState, RootAction, RootEnvironment>.combine(
    loginReducer.pullback(state: \.loginState,
                          action: /RootAction.login,
                          environment: { LoginEnvironment(mainQueue: $0.mainQueue) }),
    Reducer { state, action, env in
        return .none
    }
)

struct RootView: View {
    let store: Store<RootState, RootAction>

    var body: some View {
        LoginView(store: store.scope(state: \.loginState,
                                     action: RootAction.login))
        //        if session.accessToken == nil {
        //            LoginView(viewModel: .init(session: session))
        //        } else {
        //            RootTabView()
        //        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: Store(initialState: RootState(),
                              reducer: rootReducer,
                              environment: RootEnvironment(
                                mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                              )))
    }
}
