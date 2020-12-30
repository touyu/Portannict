//
//  TestView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/24.
//

import SwiftUI
import Fluxer

struct TestView: View {
    @ObservedObject var viewModel: TestViewModel

    @State private var isLogin: Bool = true

    init(viewModel: TestViewModel) {
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

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(viewModel: .init())
    }
}
