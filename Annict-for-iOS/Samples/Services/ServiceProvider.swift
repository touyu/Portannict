//
//  ServiceProvider.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/22.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import Foundation

protocol ServiceProviderType: class {
    var counterService: CounterService { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var counterService: CounterService = .init(provider: self)
}
