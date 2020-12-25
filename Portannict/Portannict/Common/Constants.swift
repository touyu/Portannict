//
//  Constants.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/20.
//

import SwiftUI

struct Constants {
    @Environment(\.envValues) static var envValues

    static let rootURI = "https://api.annict.com"
    static let callbackURLScheme = "annict://"
    static let redirectURI = "annict://oauth"
    static var clientID = envValues["AnnictClientID"] as! String
    static var clientSecret = envValues["AnnictClientSecret"] as! String
    static let baseImageURL = envValues["BaseImageURL"] as! String

    static var oauthURL: URL! {
        var oauthURL = "\(rootURI)/oauth/authorize"
        oauthURL += "?client_id=\(clientID)"
        oauthURL += "&response_type=code"
        oauthURL += "&redirect_uri=\(redirectURI)"
        oauthURL += "&scope=read+write"
        return URL(string: oauthURL)!
    }
}
