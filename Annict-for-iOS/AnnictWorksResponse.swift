//
//  AnnictWorksResponse.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import Himotoki


// MARK: - AnnictWorksResponse

struct AnnictWorksResponse {
    var works: [AnnictWorkResponse]
    
    init (_ e: Extractor) {
        works = try! e <|| "works"
    }
}

extension AnnictWorksResponse: Decodable {
    static func decode(_ e: Extractor) throws -> AnnictWorksResponse {
        return try castOrFail(AnnictWorksResponse(e))
    }
}


// MARK: - AnnictWorkResponse

struct AnnictWorkResponse {
    var id: Int
    var title: String
    var mediaText: String
    var seasonNameText: String?
    var officialSiteURL: String?
    var wikipediaURL: String?
    var twitterUserName: String?
    var twitterHashTag: String?
    
    init (_ e: Extractor) {
        id = try! e <| "id"
        title = try! e <| "title"
        mediaText = try! e <| "media_text"
        seasonNameText = try! e <|? "season_name_text"
        officialSiteURL = try! e <|? "official_site_url"
        wikipediaURL = try! e <|? "wikipedia_url"
        twitterUserName = try! e <|? "twitter_username"
        twitterHashTag = try! e <|? "twitter_hashtag"
    }
}

extension AnnictWorkResponse: Decodable {
    static func decode(_ e: Extractor) throws -> AnnictWorkResponse {
        return try castOrFail(AnnictWorkResponse(e))
    }
}

