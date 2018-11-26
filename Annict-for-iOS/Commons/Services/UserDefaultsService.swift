//
//  UserDefaultsService.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/24.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import RxSwift

struct UserDefaultsEvent {
    let accessToken = PublishSubject<String?>()
}

protocol UserDefaultsServiceType {
    var event: UserDefaultsEvent { get }
    func fetch<T: UserDefaultsGettable>(forKey key: UserDefaultsRepository.Key, type: T.Type) -> T?
    func save<T: UserDefaultsStorable>(value: T?, forKey key: UserDefaultsRepository.Key)
}

final class UserDefaultsService: BaseService, UserDefaultsServiceType {
    let event = UserDefaultsEvent()
    
    func fetch<T: UserDefaultsGettable>(forKey key: UserDefaultsRepository.Key, type: T.Type) -> T? {
        return UserDefaultsRepository.fetch(forKey: key, type: type)
    }
    
    func save<T: UserDefaultsStorable>(value: T?, forKey key: UserDefaultsRepository.Key) {
        UserDefaultsRepository.save(value: value, forKey: key)
        publishEventIfNeeded(value: value, key: key)
    }
    
    private func publishEventIfNeeded<T: UserDefaultsStorable>(value: T?, key: UserDefaultsRepository.Key) {
        switch key {
        case .accessToken:
            event.accessToken.onNext(value as? String)
        default:
            break
        }
    }
}
