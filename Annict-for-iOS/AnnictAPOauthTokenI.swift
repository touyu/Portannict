//
//  AnnictAPOauthTokenI.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import APIKit
import Himotoki


typealias AnnictAPIClient = Session


// MARK: - AnnictAPI

final class AnnictAPI {

    struct OauthToken: AnnictAPIRequest {
        var code: String
        
        typealias Response = AnnictOauthTokenResponse
        
        var method: HTTPMethod {
            return .post
        }
        
        var path: String {
            return "/oauth/token"
        }
        
        var parameters: Any? {
            return [
                "client_id": AnnictConsts.clientID,
                "client_secret": AnnictConsts.clientSecret,
                "grant_type": "authorization_code",
                "redirect_uri": AnnictConsts.redirectURI,
                "code": code
            ]
        }
    }
}
