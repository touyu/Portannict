//
//  RootView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/24.
//

import SwiftUI

struct RootView: View {
    @State private var isLogin: Bool = true

    var body: some View {
        if isLogin {
            RootTabView()
        } else {
            LoginView()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
