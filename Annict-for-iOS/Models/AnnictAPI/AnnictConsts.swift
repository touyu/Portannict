//
//  AnnictConsts.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import Foundation

import Keys

class AnnictConsts {
    
    static let rootURI = "https://api.annict.com"
    
    static let redirectURI = "annict://oauth"
    
    static var clientID: String {
        return AnnictForIOSKeys().annictClientID
    }
    
    static var clientSecret: String {
        return AnnictForIOSKeys().annictClientSecret
    }
    
    static func oauthURL() -> URL? {
        var oauthURL = "\(AnnictConsts.rootURI)/oauth/authorize"
        oauthURL += "?client_id=\(AnnictConsts.clientID)"
        oauthURL += "&response_type=code"
        oauthURL += "&redirect_uri=\(redirectURI)"
        oauthURL += "&scope=read+write"
        return URL(string: oauthURL)
    }
    
    static var accessToken: String {
        get {
            if AppConfig.isTesting() {
                return AnnictForIOSKeys().annictAccessToken
            }
            if let accessToken = UserDefaults.standard.string(forKey: "annict_access_token") {
                return accessToken
            } else {
                return ""
            }
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "annict_access_token")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var userID: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "annict_user_id")
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "annict_user_id")
            UserDefaults.standard.synchronize()
        }
    }
}
