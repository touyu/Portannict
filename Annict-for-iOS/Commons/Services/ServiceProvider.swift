//
//  ServiceProvider.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/22.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import Foundation

protocol ServiceProviderType: class {
    var apiService: APIServiceType { get }
    var workAPIService: WorkAPIServiceType { get }
    var userDefaultsService: UserDefaultsServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var apiService: APIServiceType = APIService(provider: self)
    lazy var workAPIService: WorkAPIServiceType = WorkAPIService(provider: self)
    lazy var userDefaultsService: UserDefaultsServiceType = UserDefaultsService(provider: self)
}
