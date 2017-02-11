//
//  AnnictAPIRequest.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/11.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import APIKit
import Himotoki

// MARK: - AnnictAPIRequest

protocol AnnictAPIRequest: Request {}

extension AnnictAPIRequest {
    var baseURL: URL {
        return URL(string: "https://api.annict.com")!
    }
}

extension AnnictAPIRequest where Response: Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try decodeValue(object)
    }
}
