//
//  AnnictEpisodesResponse.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/12.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import Himotoki


// MARK: - AnnictEpisodesResponse

struct AnnictEpisodesResponse {
    var episodes: [AnnictEpisodeResponse]
    
    init (_ e: Extractor) {
        episodes = try! e <|| "episodes"
    }
}

extension AnnictEpisodesResponse: Himotoki.Decodable {
    static func decode(_ e: Extractor) throws -> AnnictEpisodesResponse {
        return try castOrFail(AnnictEpisodesResponse(e))
    }
}

struct AnnictEpisodeResponse {
    var id: Int
    var sortNumber: Int?
    var numberText: String?
    var title: String?
    
    init (_ e: Extractor) {
        id = try! e <| "id"
        numberText = try! e <|? "number_text"
        title = try! e <|? "title"
        sortNumber = try! e <|? "sort_number"
    }
}

extension AnnictEpisodeResponse: Himotoki.Decodable {
    static func decode(_ e: Extractor) throws -> AnnictEpisodeResponse {
        return try castOrFail(AnnictEpisodeResponse(e))
    }
}
