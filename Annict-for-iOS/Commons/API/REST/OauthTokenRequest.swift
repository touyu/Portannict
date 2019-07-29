//
//  OauthTokenRequest.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import Foundation

struct OauthTokenRequest: HTTPRequest {
    typealias Response = OauthTokenResponse

    var url: String {
        return Constants.rootURI + "/oauth/token"
    }

    var method: HTTPMethod {
        return .post
    }

    var parameters: [String : Any] {
        return ["client_id": Constants.clientID,
                "client_secret": Constants.clientSecret,
                "grant_type": "authorization_code",
                "redirect_uri": Constants.redirectURI,
                "code": code]
    }

    private var code: String

    init(code: String) {
        self.code = code
    }
}

struct OauthTokenResponse: Codable {
    var accessToken: String
}
