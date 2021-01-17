//
//  Network.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/06.
//

import Foundation
import Apollo
import Combine

enum NetworkError: Error {
    case notFoundData
}

final class Network {
    static let shared = Network()

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

extension ApolloClient {
    func fetch<Query: GraphQLQuery>(query: Query) -> AnyPublisher<Query.Data, Error> {
        return Future<Query.Data, Error> { [weak self] promise in
            self?.fetch(query: query) { result in
                switch result {
                case .success(let data):
                    guard let data = data.data else {
                        promise(.failure(NetworkError.notFoundData))
                        return
                    }
                    promise(.success(data))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func perform<Mutation: GraphQLMutation>(mutation: Mutation) -> AnyPublisher<Mutation.Data, Error> {
        return Future<Mutation.Data, Error> { [weak self] promise in
            self?.perform(mutation: mutation) { result in
                switch result {
                case .success(let data):
                    guard let data = data.data else {
                        promise(.failure(NetworkError.notFoundData))
                        return
                    }
                    promise(.success(data))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
