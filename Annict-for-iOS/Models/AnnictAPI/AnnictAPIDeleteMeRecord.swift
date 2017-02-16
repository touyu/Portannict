//
//  AnnictAPIDeleteMeRecord.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import APIKit
import Himotoki

extension AnnictAPI {
    
    struct DeleteMeRecord: AnnictAPIRequest {
        var id: Int
        
        typealias Response = Void
        
        var method: HTTPMethod {
            return .delete
        }
        
        var path: String {
            return "/v1/me/records/\(id)"
        }
        
        var parameters: Any? {
            return ["access_token": AnnictConsts.accessToken]
        }
        
        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> () {
            return
        }
    }
}
