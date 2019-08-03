//
//  Constants.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import Keys

struct Constants {
    static let rootURI = "https://api.annict.com"
    static let redirectURI = "annict://oauth"

    static var clientID: String {
        return AnnictForIOSKeys().annictClientID
    }

    static var clientSecret: String {
        return AnnictForIOSKeys().annictClientSecret
    }
    
    static let baseImageURL = AnnictForIOSKeys().baseImageURL

    static var oauthURL: URL? {
        var oauthURL = "\(rootURI)/oauth/authorize"
        oauthURL += "?client_id=\(clientID)"
        oauthURL += "&response_type=code"
        oauthURL += "&redirect_uri=\(redirectURI)"
        oauthURL += "&scope=read+write"
        return URL(string: oauthURL)
    }
}

