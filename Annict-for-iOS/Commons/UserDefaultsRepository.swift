//
//  UserDefaultsRepository.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/24.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import Foundation
import Apollo

final class UserDefaultsRepository {
    enum Key: String {
        case accessToken = "access_token"
        case viewer = "viewer"
        case viewerAllWorks = "viewer_all_works"
    }
    
    private static var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    static func fetch<T: UserDefaultsGettable>(forKey key: Key, type: T.Type) -> T? {
        return T.get(key: key.rawValue, userDefaults: userDefaults)
    }
    
    static func save<T: UserDefaultsStorable>(value: T?, forKey key: Key) {
        T.save(key: key.rawValue, value: value, userDefaults: userDefaults)
    }
    
    static func fetch<T: GraphQLSelectionSet>(forKey key: Key, type: T.Type) -> T? {
        guard let resultMap = userDefaults.dictionary(forKey: key.rawValue) else { return nil }
        return T(unsafeResultMap: resultMap)
    }
    
    static func save<T: GraphQLSelectionSet>(value: T?, forKey key: Key) {
        return userDefaults.set(value?.resultMap, forKey: key.rawValue)
    }
}

typealias UserDefaultsSerializable = UserDefaultsGettable & UserDefaultsStorable

protocol UserDefaultsGettable {
    static func get(key: String, userDefaults: UserDefaults) -> Self?
}

protocol UserDefaultsStorable {
    static func save(key: String, value: Self?, userDefaults: UserDefaults)
}

extension String: UserDefaultsSerializable {
    static func get(key: String, userDefaults: UserDefaults) -> String? {
        return userDefaults.string(forKey: key)
    }
    
    static func save(key: String, value: String?, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }
}

extension Int: UserDefaultsSerializable {
    static func get(key: String, userDefaults: UserDefaults) -> Int? {
        return userDefaults.integer(forKey: key)
    }
    
    static func save(key: String, value: Int?, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }
}

extension UserDefaultsGettable where Self: Decodable {
    static func get(key: String, userDefaults: UserDefaults) -> Self? {
        return userDefaults.decodable(forKey: key)
    }
}

extension UserDefaultsStorable where Self: Encodable {
    static func save(key: String, value: Self?, userDefaults: UserDefaults) {
        userDefaults.set(encodable: value, forKey: key)
    }
}

extension UserDefaults {
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        } else {
            assertionFailure("Encodable \(T.self) is not _actually_ encodable to any data...Please fix 😭")
        }
    }
    
    func decodable<T: Decodable>(forKey key: String) -> T? {
        guard let decodableData = data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: decodableData)
    }
}
