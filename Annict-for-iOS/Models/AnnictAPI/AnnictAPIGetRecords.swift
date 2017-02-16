//
//  AnnictAPIGetRecords.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import APIKit
import Himotoki

extension AnnictAPI {
    
    struct GetRecords: AnnictAPIRequest {
        var episodeID: Int?
        var page: Int
        var perPage: Int
        var sortID: Order
        
        init(episodeID: Int? = nil,
             page: Int = 1,
             perPage: Int = 30,
             sortID: Order = .descending) {
            self.episodeID = episodeID
            self.page = page
            self.perPage = perPage
            self.sortID = sortID
        }
        
        typealias Response = AnnictRecordsResponse
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/v1/records"
        }
        
        var parameters: Any? {
            var params:[String: Any] = [:]
            params["access_token"] = AnnictConsts.accessToken
            params["filter_episode_id"] = self.episodeID ?? nil
            params["page"] = page
            params["per_page"] = perPage
            params["sort_id"] = sortID.rawValue
            return params
        }
    }
}
