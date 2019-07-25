//
//  AnnictGraphQL.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/28.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import Apollo
import ApolloSQLite

final class AnnictGraphQL {
    private static var baseURL: URL {
        return URL(string: "https://api.annict.com/graphql")!
    }
    
    private static var headers: [AnyHashable : Any] {
        guard let token = UserDefaultsRepository.fetch(forKey: .accessToken, type: String.self) else { return [:] }
        return ["Authorization": "Bearer \(token)"]
    }
    
    private static var configuration: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = headers
        return config
    }
    
    static var client: ApolloClient = makeClient()

    static func resetClient() {
        client = makeClient()
    }

    private static func makeClient() -> ApolloClient {
        let transport = HTTPNetworkTransport(url: baseURL, configuration: configuration)
        do {
            let fileURL = try temporarySQLiteFileURL()
            let sqliteCache = try SQLiteNormalizedCache(fileURL: fileURL)
            return ApolloClient(networkTransport: transport, store: ApolloStore(cache: sqliteCache))
        } catch {
            return ApolloClient(networkTransport: transport)
        }
    }
    
    private static func temporarySQLiteFileURL() throws -> URL {
        let applicationSupportPath = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first!
        let applicationSupportURL = URL(fileURLWithPath: applicationSupportPath)
        
        let temporaryDirectoryURL = try FileManager.default.url(
            for: .cachesDirectory,
            in: .userDomainMask,
            appropriateFor: applicationSupportURL,
            create: true)
        return temporaryDirectoryURL.appendingPathComponent("db.sqlite3")
    }
}
