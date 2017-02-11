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
    
    init (_ e: Extractor) {
        id = try! e <| "id"
        title = try! e <| "title"
    }
}

extension AnnictWorkResponse: Decodable {
    static func decode(_ e: Extractor) throws -> AnnictWorkResponse {
        return try castOrFail(AnnictWorkResponse(e))
    }
}

