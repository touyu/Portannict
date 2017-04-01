//
//  AnnictAPIGetMeFollowingActivities.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/04/01.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import APIKit
import Himotoki

extension AnnictAPI {
    
    struct GetMeFollowingActivities: AnnictAPIRequest {
        var page: Int = 1
        
        typealias Response = AnnictActivitiesResponse
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/v1/me/following_activities"
        }
        
        var parameters: Any? {
            var params:[String: Any] = [:]
            params["access_token"] = AnnictConsts.accessToken
            params["page"] = page
            params["per_page"] = 30
            params["sort_id"] = "desc"
            return params
        }
    }
}
