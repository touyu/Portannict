//
//  RootView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/24.
//

import SwiftUI
import Fluxer

struct RootView: View {
    @ObservedObject var viewModel: RootViewModel

    @State private var isLogin: Bool = true

    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            TextField("AAAA", value: $viewModel.state.number, formatter: NumberFormatter())
            Button(viewModel: viewModel, action: .increment) {
                Text("AAAA")
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: .init())
    }
}
