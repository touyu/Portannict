//
//  AnnictRecordsResponse.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import Himotoki


// MARK: - AnnictEpisodesResponse

struct AnnictRecordsResponse {
    var records: [AnnictRecordResponse]
    
    init (_ e: Extractor) {
        records = try! e <|| "records"
    }
}

extension AnnictRecordsResponse: Decodable {
    static func decode(_ e: Extractor) throws -> AnnictRecordsResponse {
        return try castOrFail(AnnictRecordsResponse(e))
    }
}

struct AnnictRecordResponse {
    var id: Int
    var comment: String?
    var rating: Int?
    var createdAt: String?
    var user: AnnictUserResponse
    var work: AnnictWorkResponse
    
    init (_ e: Extractor) {
        id = try! e <| "id"
        comment = try! e <|? "comment"
        rating = try! e <|? "rating"
        createdAt = try! e <|? "created_at"
        user = try! e <| "user"
        work = try! e <| "work"
    }
}

extension AnnictRecordResponse: Decodable {
    static func decode(_ e: Extractor) throws -> AnnictRecordResponse {
        return try castOrFail(AnnictRecordResponse(e))
    }
}
