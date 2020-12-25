//
//  LoginView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/24.
//

import SwiftUI
import Combine
import SafariServices
import Fluxer

struct LoginView: View {
    typealias ViewModel = LoginViewModel

    @ObservedObject var viewModel: LoginViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 60) {
            Text("Login Screen")
            Button(viewModel: viewModel, action: .login) {
                Text("Login")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init())
    }
}
