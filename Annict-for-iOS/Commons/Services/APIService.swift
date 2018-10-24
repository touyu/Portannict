//
//  APIService.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/24.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import RxSwift

protocol APIServiceType {
    func getOauthToken(code: String) -> Single<OauthTokenRequest.Response>
}

final class APIService: BaseService, APIServiceType {
    func getOauthToken(code: String) -> Single<OauthTokenRequest.Response> {
        let request = OauthTokenRequest(code: code)
        return HTTPClient.send(request: request)
    }
}
