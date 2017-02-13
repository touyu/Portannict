//
//  AnnictAPIPostMeRecords.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import APIKit
import Himotoki

extension AnnictAPI {
    
    struct PostMeRecords: AnnictAPIRequest {
        var episodeID: Int!
        var comment: String?
        var rating: Int?
        var shareTwitter = false
        var shareFacebook = false
        
        typealias Response = AnnictRecordResponse
        
        var method: HTTPMethod {
            return .post
        }
        
        var path: String {
            return "/v1/me/records"
        }
        
        var parameters: Any? {
            var params:[String: Any] = [:]
            params["access_token"] = AnnictConsts.accessToken
            params["episode_id"] = String(episodeID)
            params["comment"] = comment ?? nil
            params["rating"] = rating ?? nil
            params["share_twitter"] = shareTwitter.description
            params["share_facebook"] = shareFacebook.description
            return params
        }
    }
}
