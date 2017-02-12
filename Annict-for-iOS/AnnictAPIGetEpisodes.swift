//
//  AnnictAPIGetEpisodes.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/12.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import APIKit
import Himotoki

extension AnnictAPI {
    
    struct GetEpisodes: AnnictAPIRequest {
        var workID: Int? = nil
        
        typealias Response = AnnictEpisodesResponse
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/v1/episodes"
        }
        
        var parameters: Any? {
            var params:[String: Any] = [:]
            params["access_token"] = AnnictConsts.accessToken
            params["filter_work_id"] = self.workID ?? nil
            params["sort_sort_number"] = "asc"
            return params
        }
    }
}
