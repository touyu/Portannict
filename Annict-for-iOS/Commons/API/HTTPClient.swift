//
//  HTTPClient.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import Foundation
import RxSwift

enum HTTPClientError: Error {
    case noData
    case decodeError
}

enum HTTPMethod: String {
//    case get = "GET"
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
    enum Result<T> {
        case success(T)
        case failure(Error)
    }

    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    static func send<T: HTTPRequest>(request: T, completion: ((Result<T.Response>) -> Void)?) {
        let request = request.buildRequest()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion?(.failure(error))
                    return
                }

                guard let data = data else {
                    completion?(.failure(HTTPClientError.noData))
                    return
                }

                do {
                    let res = try decoder.decode(T.Response.self, from: data)
                    completion?(.success(res))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    static func send<T: HTTPRequest>(request: T) -> Single<T.Response> {
        return Single<T.Response>.create { singleEvent in
            send(request: request) { result in
                switch result {
                case .success(let value):
                    singleEvent(.success(value))
                case .failure(let error):
                    singleEvent(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
