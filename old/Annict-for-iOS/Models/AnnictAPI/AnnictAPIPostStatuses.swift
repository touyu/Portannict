//
//  AnnictAPIPostStatuses.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import APIKit
import Himotoki

extension AnnictAPI {
    
    struct PostStatuses: AnnictAPIRequest {
        var workID: Int!
        var kind: AnimeStatus!
        
        typealias Response = Void
        
        var method: HTTPMethod {
            return .post
        }
        
        var path: String {
            return "/v1/me/statuses"
        }
        
        var parameters: Any? {
            var params:[String: Any] = [:]
            params["access_token"] = AnnictConsts.accessToken
            params["work_id"] = String(workID)
            params["kind"] = kind.rawValue
            return params
        }
        
        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> () {
            return
        }
    }
}
