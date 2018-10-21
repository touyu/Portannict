//
//  AnnictRecordsResponse.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit
import Himotoki


// MARK: - AnnictEpisodesResponse

struct AnnictRecordsResponse {
    var records: [AnnictRecordResponse]
    
    init (_ e: Extractor) {
        records = try! e <|| "records"
    }
}

extension AnnictRecordsResponse: Himotoki.Decodable {
    static func decode(_ e: Extractor) throws -> AnnictRecordsResponse {
        return try castOrFail(AnnictRecordsResponse(e))
    }
}

enum RatingState: String {
    case bad = "bad"
    case average = "average"
    case good = "good"
    case great = "great"
    
    var localizedString: String {
        return self.rawValue.localized(withTableName: "AnnictBaseLocalizable")
    }
    
    var color: UIColor {
        switch self {
        case .bad:
            return UIColor(hex: 0x757575)
        case .average:
            return UIColor(hex: 0xff9100)
        case .good:
            return UIColor(hex: 0x00c853)
        case .great:
            return UIColor(hex: 0x00b0ff)
        }
    }
}

struct AnnictRecordResponse {
    var id: Int
    var comment: String?
    var rating: Int? // deprecation
    var createdAt: String?
    var user: AnnictUserResponse?
    var work: AnnictWorkResponse?
    var ratingState: RatingState? {
        guard let ratingState = self.ratingStateString else { return nil }
        return RatingState(rawValue: ratingState)
    }
    
    private var ratingFloat: Float? {
        didSet {
            guard let ratingFloat = ratingFloat else { return }
            rating = Int(ratingFloat)
        }
    }
    private var ratingStateString: String?
    
    init (_ e: Extractor) {
        id = try! e <| "id"
        comment = try! e <|? "comment"
        ratingFloat = try! e <|? "rating"
        createdAt = try! e <|? "created_at"
        user = try! e <|? "user"
        work = try! e <|? "work"
        ratingStateString = try! e <|? "rating_state"
    }
}

extension AnnictRecordResponse: Himotoki.Decodable {
    static func decode(_ e: Extractor) throws -> AnnictRecordResponse {
        return try castOrFail(AnnictRecordResponse(e))
    }
}
