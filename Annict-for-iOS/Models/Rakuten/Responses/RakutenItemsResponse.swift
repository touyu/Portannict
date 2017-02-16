//
//  RakutenItemsResponse.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/14.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import Himotoki


// MARK: - AnnictOauthTokenResponse

struct RakutenItemsResponse {
    var items: [RakutenItemResponse]?
    
    init (_ e: Extractor) {
        items = try! e <||? "Items"
    }
}

extension RakutenItemsResponse: Decodable {
    static func decode(_ e: Extractor) throws -> RakutenItemsResponse {
        return try castOrFail(RakutenItemsResponse(e))
    }
}


// MARK: - RakutenItemResponse

struct RakutenItemResponse {
    var mediumImageURLs: [String]?
    
    init (_ e: Extractor) {
        mediumImageURLs = try! e <||? "mediumImageUrls"
    }
}

extension RakutenItemResponse: Decodable {
    static func decode(_ e: Extractor) throws -> RakutenItemResponse {
        return try castOrFail(RakutenItemResponse(e))
    }
}
