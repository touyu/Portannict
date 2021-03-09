//
//  SettingView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/18.
//

import SwiftUI
import ComposableArchitecture

struct SettingState: Equatable {

}

enum SettingAction: Equatable {
    case logout
}

struct SettingEnvironment: Equatable {

}

let settingReducer = Reducer<SettingState, SettingAction, SettingEnvironment> { state, action, env in
    switch action {
    case .logout:
        return .none
    }
}

struct SettingView: View {
    let store: Store<SettingState, SettingAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                Form {
                    Section {
                        HStack {
                            Text("バージョン")
                            Spacer()
                            Text(Constants.appVersion)
                                .foregroundColor(.gray)
                        }
                        NavigationLink(destination: LicensesView()) {
                            Text("ライセンス表記")
                        }
                    }

                    Button(action: {
                        viewStore.send(.logout)
                    }, label: {
                        Text("ログアウト")
                            .foregroundColor(.red)
                    })
                }
                .navigationTitle("設定")
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(store: Store(initialState: SettingState(),
                                 reducer: settingReducer,
                                 environment: SettingEnvironment()))
    }
}
