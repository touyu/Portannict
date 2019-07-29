//
//  PortannictExtension.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/25.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import Foundation

class PortannictExtension<T> {
    let base: T
    init(_ base: T) {
        self.base = base
    }
}

protocol PortannictExtensionCompatible {
    associatedtype Compatible
    static var pa: PortannictExtension<Compatible>.Type { get }
    var pa: PortannictExtension<Compatible> { get }
}

extension PortannictExtensionCompatible {
    static var pa: PortannictExtension<Self>.Type {
        return PortannictExtension<Self>.self
    }

    var pa: PortannictExtension<Self> {
        return PortannictExtension(self)
    }
}
