//
//  AnnictAPIGetMe.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/04/01.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import APIKit
import Himotoki

extension AnnictAPI {
    
    struct GetMe: AnnictAPIRequest {
        
        typealias Response = AnnictUserResponse
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/v1/me"
        }
        
        var parameters: Any? {
            var params:[String: Any] = [:]
            params["access_token"] = AnnictConsts.accessToken
            return params
        }
    }
}
