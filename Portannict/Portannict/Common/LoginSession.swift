//
//  LoginSession.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/25.
//

import SwiftUI

final class LoginSession: ObservableObject {
    @Published var accessToken: String? = UserDefaults.standard.string(forKey: "accessToken") {
        didSet {
            UserDefaults.standard.setValue(accessToken, forKey: "accessToken")
        }
    }
}
