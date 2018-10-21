//
//  AnnictUsersResponse.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import Himotoki


// MARK: - AnnictUsersResponse

struct AnnictUsersResponse {
    var users: [AnnictUserResponse]
    
    init (_ e: Extractor) {
        users = try! e <|| "users"
    }
}

extension AnnictUsersResponse: Himotoki.Decodable {
    static func decode(_ e: Extractor) throws -> AnnictUsersResponse {
        return try castOrFail(AnnictUsersResponse(e))
    }
}

struct AnnictUserResponse {
    var id: Int
    var username: String?
    var name: String?
    var description: String?
    var backgroundImageURL: String?
    var recordsCount: Int?
    
    var avatarURL: URL? {
        guard let avatarURLString = self.avatarURLString else { return nil }
        return URL(string: avatarURLString)
    }
    
    private var avatarURLString: String?
    
    init (_ e: Extractor) {
        id = try! e <| "id"
        username = try! e <|? "username"
        name = try! e <|? "name"
        description = try! e <|? "description"
        avatarURLString = try! e <|? "avatar_url"
        backgroundImageURL = try! e <|? "background_image_url"
        recordsCount = try! e <|? "records_count"
    }
    
    init (dictionary: [String: Any]) {
        id = dictionary["id"] as! Int
        username = dictionary["username"] as? String
        name = dictionary["name"] as? String
        description = dictionary["description"]  as? String
        avatarURLString = dictionary["avatarURL"] as? String
        backgroundImageURL = dictionary["backgroundImageURL"] as? String
        recordsCount = dictionary["records_count"] as? Int
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary["id"] = id
        dictionary["username"] = username
        dictionary["name"] = name
        dictionary["description"] = description
        dictionary["avatarURL"] = avatarURLString
        dictionary["backgroundImageURL"] = backgroundImageURL
        dictionary["records_count"] = recordsCount
        return dictionary
    }
}

extension AnnictUserResponse: Himotoki.Decodable {
    static func decode(_ e: Extractor) throws -> AnnictUserResponse {
        return try castOrFail(AnnictUserResponse(e))
    }
}
