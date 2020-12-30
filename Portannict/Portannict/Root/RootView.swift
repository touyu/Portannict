//
//  RootView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/20.
//

import SwiftUI

struct RootView: View {
    typealias ViewModel = RootViewModel

    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var session: LoginSession

    var body: some View {
        if session.accessToken == nil {
            LoginView(viewModel: .init(session: session))
        } else {
            RootTabView()
        }
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: .init())
    }
}
