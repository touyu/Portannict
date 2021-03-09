//
//  LoginView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/24.
//

import SwiftUI
import Combine
import Fluxer

struct LoginView2: View {
    typealias ViewModel = LoginViewModel
    @ObservedObject var viewModel: LoginViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            MonochromeImage("killlakill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

            Rectangle()
                .fill(Color.black)
                .opacity(0.7)

            VStack(spacing: 160) {
                Text("Portannict")
                    .font(.system(size: 62, weight: .black))
                    .foregroundColor(Color(hex: 0xF85B73))
                    .kerning(1.4)
                Button(viewModel: viewModel, action: .login) {
                    Text("ログイン")
                        .font(.system(size: 18), weight: .bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 180, height: 44)
                .background(Color.white)
                .clipShape(Capsule())
            }
        }
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
    }
}

struct LoginView2_Previews: PreviewProvider {
    static var previews: some View {
        LoginView2(viewModel: .init(session: LoginSession()))
    }
}
