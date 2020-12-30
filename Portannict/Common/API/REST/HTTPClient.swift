//
//  HTTPClient.swift
//  Portannict
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import Foundation
import Combine

enum HTTPClientError: Error {
    case unknown
    case noData
    case decode
    case validatedStatusCode
}

enum HTTPMethod: String {
    case post = "POST"
}

protocol HTTPRequest {
    associatedtype Response: Decodable
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
}

extension HTTPRequest {
    func buildRequest() -> URLRequest {
        let url = URL(string: self.url)!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        return request
    }
}

final class HTTPClient {
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    static func send<T: HTTPRequest>(request: T) -> AnyPublisher<T.Response, Error> {
        let request = request.buildRequest()
        return URLSession.shared.dataTaskPublisher(for: request)
            .validate(statusCode: 200..<300)
            .map(\.data)
            .decode(type: T.Response.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

extension URLSession.DataTaskPublisher {
    func validate<S: Sequence>(statusCode range: S) -> Self where S.Iterator.Element == Int {
        tryMap { data, response -> Data in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                throw HTTPClientError.unknown
            }

            if range.contains(statusCode) {
                return data
            } else {
                throw HTTPClientError.validatedStatusCode
            }
        }.upstream
    }
}
