//
//  RxApollo.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import RxSwift
import Apollo

enum RxApolloError: Error {
    case graphQLErrors([GraphQLError])
}

final class ApolloReactiveExtensions {
    private let client: ApolloClient
    
    fileprivate init(_ client: ApolloClient) {
        self.client = client
    }
    
    func fetchMaybe<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .returnCacheDataElseFetch,
        queue: DispatchQueue = DispatchQueue.main) -> Maybe<Query.Data> {
        return Maybe.create { maybe in
            let _ = self.client.fetch(query: query, cachePolicy: cachePolicy, queue: queue) { result in
                switch result {
                case .success(let value):
                    if let data = value.data {
                        maybe(.success(data))
                    } else {
                        maybe(.completed)
                    }
                case .failure(let error):
                    maybe(.error(error))
                }
            }
            
            return Disposables.create {
//                cancellable.cancel()
            }
        }
    }
    
    func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .returnCacheDataElseFetch,
        queue: DispatchQueue = DispatchQueue.main) -> Observable<Query.Data> {
        return Observable.create { observer in
            let _ = self.client.fetch(query: query, cachePolicy: cachePolicy, queue: queue) { result in
                switch result {
                case .success(let value):
                    if let data = value.data {
                        observer.on(.next(data))
                    } else {
                        observer.on(.completed)
                    }
                case .failure(let error):
                    observer.on(.error(error))
                }
            }

            return Disposables.create {
                //                cancellable.cancel()
            }
        }
    }
    
    func watch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .returnCacheDataElseFetch,
        queue: DispatchQueue = DispatchQueue.main) -> Observable<Query.Data> {
        return Observable.create { observer in
            let watcher = self.client.watch(query: query, cachePolicy: cachePolicy, queue: queue) { result in
                switch result {
                case .success(let value):
                    if let data = value.data {
                        observer.on(.next(data))
                    }
                case .failure(let error):
                    observer.on(.error(error))
                }
                
                // Should we silently ignore the case where `result` and `error` are both nil, or should this be an error situation?
            }
            
            return Disposables.create {
                watcher.cancel()
            }
        }
    }
    
    func perform<Mutation: GraphQLMutation>(mutation: Mutation, queue: DispatchQueue = DispatchQueue.main) -> Maybe<Mutation.Data> {
        return Maybe.create { maybe in
            let cancellable = self.client.perform(mutation: mutation, queue: queue) { result in
                switch result {
                case .success(let value):
                    if let data = value.data {
                        maybe(.success(data))
                    } else {
                        maybe(.completed)
                    }
                case .failure(let error):
                    maybe(.error(error))
                }
            }
            
            return Disposables.create {
                cancellable.cancel()
            }
        }
    }
}

extension ApolloClient {
    var rx: ApolloReactiveExtensions {
        return ApolloReactiveExtensions(self)
    }
}
