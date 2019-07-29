//
//  CachePolicy.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/03/18.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import Apollo

extension CachePolicy {
    var takeCount: Int {
        return self == .returnCacheDataAndFetch ? 2 : 1
    }
}
