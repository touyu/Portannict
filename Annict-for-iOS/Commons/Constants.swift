//
//  Constants.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import Keys

struct Constants {
    static private let rootURI = "https://api.annict.com"
    static private let redirectURI = "portannict://oauth"

    static private var clientID: String {
        return AnnictForIOSKeys().annictClientID
    }

    static var oauthURL: URL? {
        var oauthURL = "\(rootURI)/oauth/authorize"
        oauthURL += "?client_id=\(clientID)"
        oauthURL += "&response_type=code"
        oauthURL += "&redirect_uri=\(redirectURI)"
        oauthURL += "&scope=read+write"
        return URL(string: oauthURL)
    }
}

