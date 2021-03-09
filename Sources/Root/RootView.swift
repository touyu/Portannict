//
//  RootView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/20.
//

import SwiftUI
import ComposableArchitecture

struct RootState: Equatable {
    
}

enum RootAction: Equatable {
    
}

struct RootEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
}

let rootReducer = Reducer<RootState, RootAction, RootEnvironment> { state, action, env in
    return .none
}

struct RootView: View {
    let store: Store<RootState, RootAction>

    var body: some View {
        EmptyView()
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
