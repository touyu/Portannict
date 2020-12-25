//
//  RootView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/20.
//

import SwiftUI

struct RootView: View {
    typealias ViewModel = RootViewModel

    var viewModel: ViewModel

    var body: some View {
        LoginView(viewModel: .init())
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
