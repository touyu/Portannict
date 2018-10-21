//
//  AnnictGraphQLClient.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/06/11.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import Apollo
import Himotoki

struct AnnictGraphQLClient {
    static private let apollo: ApolloClient = {
        let url = URL(string: "https://api.annict.com/graphql")!
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": "bearer \(AnnictConsts.accessToken)"]
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    
    static func request<Query>(query: Query, completionHandler: ((Apollo.GraphQLResult<Query.Data>?, Error?) -> Void)? = nil) where Query: GraphQLQuery {
        DispatchQueue.global().async {
            print("\n\n-----🚀 [AnnictGraphQLClient] REQUEST 🚀-----")
            print(Query.requestString)
        }
        
        apollo.fetch(query: query) { result, error in
            completionHandler?(result, error)
        }
    }
}
