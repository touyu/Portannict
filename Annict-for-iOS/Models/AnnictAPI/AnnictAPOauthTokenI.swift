//
//  AnnictAPOauthTokenI.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import APIKit
import Himotoki
import Result


class AnnictAPIClient: Session {
    @discardableResult
    override class func send<Request : AnnictAPIRequest>(_ request: Request, callbackQueue: CallbackQueue? = nil, handler: @escaping (Result<Request.Response, SessionTaskError>) -> Void) -> SessionTask? {
        print("\n\n-----🚀 [AnnictAPIClient] REQUEST 🚀-----")
        do {
            let urlRequest = try request.buildURLRequest()
            if let HTTPMethod = urlRequest.httpMethod {
                print("[\(HTTPMethod)]")
            }
            
            if let url = urlRequest.url?.absoluteURL {
                print(url)
            }
            
            print("\n\n")
        } catch {
            print("----- [AnnictAPIClient] ERROR: buildURLRequest -----")
        }

        return super.send(request, callbackQueue: callbackQueue, handler: handler)
    }
}


// MARK: - AnnictAPI

final class AnnictAPI {

    struct OauthToken: AnnictAPIRequest {
        var code: String
        
        typealias Response = AnnictOauthTokenResponse
        
        var method: HTTPMethod {
            return .post
        }
        
        var path: String {
            return "/oauth/token"
        }
        
        var parameters: Any? {
            return [
                "client_id": AnnictConsts.clientID,
                "client_secret": AnnictConsts.clientSecret,
                "grant_type": "authorization_code",
                "redirect_uri": AnnictConsts.redirectURI,
                "code": code
            ]
        }
    }
}
