//
//  APIClient.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/31.
//

import Foundation
import Apollo
import Combine
import ComposableArchitecture

enum APIError: Error, Equatable {
    case failed(NSError)
    case notFoundData
}

final class APIClient {
    static let shared = APIClient()
    private init() {}

    func fetch<Query: GraphQLQuery>(query: Query) -> AnyPublisher<Query.Data, APIError> {
        return Future<Query.Data, APIError> { [weak self] promise in
            self?.apollo.fetch(query: query) { result in
                switch result {
                case .success(let data):
                    guard let data = data.data else {
                        promise(.failure(.notFoundData))
                        return
                    }
                    promise(.success(data))
                case .failure(let error):
                    promise(.failure(APIError.failed(error as NSError)))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func fetchEffect<Query: GraphQLQuery>(query: Query) -> Effect<Query.Data, APIError> {
        return fetch(query: query).eraseToEffect()
    }

    func perform<Mutation: GraphQLMutation>(mutation: Mutation) -> AnyPublisher<Mutation.Data, APIError> {
        return Future<Mutation.Data, APIError> { [weak self] promise in
            self?.apollo.perform(mutation: mutation) { result in
                switch result {
                case .success(let data):
                    guard let data = data.data else {
                        promise(.failure(.notFoundData))
                        return
                    }
                    promise(.success(data))
                case .failure(let error):
                    promise(.failure(APIError.failed(error as NSError)))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func performEffect<Mutation: GraphQLMutation>(mutation: Mutation) -> Effect<Mutation.Data, APIError> {
        return perform(mutation: mutation).eraseToEffect()
    }

    private var headers: [String: String] {
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else { return [:] }
        return ["Authorization": "Bearer \(token)"]
    }

    private(set) lazy var apollo: ApolloClient = {
        // The cache is necessary to set up the store, which we're going to hand to the provider
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)

        let client = URLSessionClient()
        let provider = LegacyInterceptorProvider(client: client, store: store)
        let url = URL(string: "https://api.annict.com/graphql")!

        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                                 endpointURL: url,
                                                                 additionalHeaders: headers)


        // Remember to give the store you already created to the client so it
        // doesn't create one on its own
        let apolloClient = ApolloClient(networkTransport: requestChainTransport,
                            store: store)
        apolloClient.cacheKeyForObject = { $0["id"] }
        return apolloClient
    }()
}
