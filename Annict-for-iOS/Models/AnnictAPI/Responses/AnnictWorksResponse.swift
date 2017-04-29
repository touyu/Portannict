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
    var images: AnnictWorkImages?
    private var statusString: String?
    
    var status: AnimeStatus? {
        guard let statusString = self.statusString else { return nil }
        return AnimeStatus(rawValue: statusString)
    }
    
    init (_ e: Extractor) {
        id = try! e <| "id"
        title = try! e <| "title"
        mediaText = try! e <| "media_text"
        seasonNameText = try! e <|? "season_name_text"
        officialSiteURL = try! e <|? "official_site_url"
        wikipediaURL = try! e <|? "wikipedia_url"
        twitterUserName = try! e <|? "twitter_username"
        twitterHashTag = try! e <|? "twitter_hashtag"
        statusString = try! e <|? ["status", "kind"]
        images = try! e <|? "images"
    }
}

extension AnnictWorkResponse: Decodable {
    static func decode(_ e: Extractor) throws -> AnnictWorkResponse {
        return try castOrFail(AnnictWorkResponse(e))
    }
}

struct AnnictWorkImages {
    private var recommendedURLString: String?
    
    var twitter: AnnictWorkTwitterImage?
    
    var recommendedURL: URL? {
        guard let recommendedURLString = self.recommendedURLString else { return nil }
        return URL(string: recommendedURLString)
    }
    
    init (_ e: Extractor) {
        recommendedURLString = try! e <|? "recommended_url"
        twitter = try! e <|? "twitter"
    }
}

extension AnnictWorkImages: Decodable {
    static func decode(_ e: Extractor) throws -> AnnictWorkImages {
        return try castOrFail(AnnictWorkImages(e))
    }
}

struct AnnictWorkTwitterImage {
//    var mini: String?
//    var normal: String?
    private var biggerAvatarURLString: String?
    private var originalAvatarURLString: String?
//    var original: String?
    
    var biggerAvatarURL: URL? {
        guard let biggerAvatarURLString = self.biggerAvatarURLString else { return nil }
        return URL(string: biggerAvatarURLString)
    }
    
    var originalAvatarURL: URL? {
        guard let originalAvatarURLString = self.originalAvatarURLString else { return nil }
        return URL(string: originalAvatarURLString)
    }
    
    init (_ e: Extractor) {
        biggerAvatarURLString = try! e <|? "bigger_avatar_url"
        originalAvatarURLString = try! e <|? "original_avatar_url"
        
    }
}

extension AnnictWorkTwitterImage: Decodable {
    static func decode(_ e: Extractor) throws -> AnnictWorkTwitterImage {
        return try castOrFail(AnnictWorkTwitterImage(e))
    }
}

