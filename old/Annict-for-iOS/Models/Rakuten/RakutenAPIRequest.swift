//
//  RakutenAPIRequest.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/14.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import APIKit
import Himotoki


// MARK: - AnnictAPIRequest

protocol RakutenAPIRequest: Request {}

extension RakutenAPIRequest {
    var baseURL: URL {
        return URL(string: "https://app.rakuten.co.jp")!
    }
}

extension RakutenAPIRequest where Response: Himotoki.Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try decodeValue(object)
    }
}
