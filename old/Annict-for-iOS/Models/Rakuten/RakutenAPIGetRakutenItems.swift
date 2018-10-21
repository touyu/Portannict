//
//  RakutenAPIGetRakutenItems.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/14.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import APIKit
import Himotoki


typealias RakutenAPIClient = Session


// MARK: - AnnictAPI

final class RakutenAPI {
    
    struct GetRakutenItems: RakutenAPIRequest {
        var keyword: String!
        
        typealias Response = RakutenItemsResponse
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/services/api/IchibaItem/Search/20140222"
        }
        
        var parameters: Any? {
            return [
                "applicationId": "1002192611477462302",
                "keyword": keyword,
                "genreId": "553550",
                "hits": 1,
                "elements": "mediumImageUrls",
                "availability": 0,
                "formatVersion": 2,
            ]
        }
    }
}
