//
//  PortannictApp.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/11.
//

import SwiftUI

@main
struct PortannictApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: .init())
        }
    }
}
