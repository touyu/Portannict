//
//  BaseService.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/22.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import Foundation

class BaseService {
    unowned let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
}
