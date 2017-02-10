//
//  AnnictOauthTokenResponse.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import Himotoki


// MARK: - AnnictOauthTokenResponse

struct AnnictOauthTokenResponse {
    var accessToken: String
    var tokenType: String
    var scope: String
    var createdAt: Int
    
    init (_ e: Extractor) {
        accessToken = try! e <| "access_token"
        tokenType   = try! e <| "token_type"
        scope       = try! e <| "scope"
        createdAt   = try! e <| "created_at"
    }
}

extension AnnictOauthTokenResponse: Decodable {
    static func decode(_ e: Extractor) throws -> AnnictOauthTokenResponse {
        return try castOrFail(AnnictOauthTokenResponse(e))
    }
}
