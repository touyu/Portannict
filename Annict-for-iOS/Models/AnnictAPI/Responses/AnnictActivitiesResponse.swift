//
//  AnnictActivitiesResponse.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/04/01.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import Himotoki


// MARK: - AnnictActivitiesResponse

struct AnnictActivitiesResponse {
    var activities: [AnnictActivityResponse]
    
    init (_ e: Extractor) {
        activities = try! e <|| "activities"
    }
}

extension AnnictActivitiesResponse: Decodable {
    static func decode(_ e: Extractor) throws -> AnnictActivitiesResponse {
        return try castOrFail(AnnictActivitiesResponse(e))
    }
}

enum ActivityAction: String {
    case createRecord = "create_record"
    case createMultipleRecords = "create_multiple_records"
    case createStatus = "create_status"
}

struct AnnictActivityResponse {
    var id: Int
    var user: AnnictUserResponse?
    var createdAt: String?
    var work: AnnictWorkResponse?
    var record: AnnictRecordResponse?
    var episode: AnnictEpisodeResponse?
    private var actionString: String?
    private var statusString: String?
    
    var action: ActivityAction? {
        guard let actionString = self.actionString else { return nil }
        return ActivityAction(rawValue: actionString)
    }
    
    var status: AnimeStatus? {
        guard let statusString = self.statusString else { return nil }
        return AnimeStatus(rawValue: statusString)
    }
    
    init (_ e: Extractor) {
        id = try! e <| "id"
        user = try! e <|? "user"
        actionString = try! e <|? "action"
        createdAt = try! e <|? "created_at"
        work = try! e <|? "work"
        statusString = try! e <|? ["status", "kind"]
        record = try! e <|? "record"
        episode = try! e <|? "episode"
    }
}

extension AnnictActivityResponse: Decodable {
    static func decode(_ e: Extractor) throws -> AnnictActivityResponse {
        return try castOrFail(AnnictActivityResponse(e))
    }
}
