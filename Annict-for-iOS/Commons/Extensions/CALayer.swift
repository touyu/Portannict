//
//  CALayer.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/25.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

extension CALayer {
    private var keyPath: String {
        return "continuousCorners"
    }

    var smoothCorners: Bool {
        get { return value(forKeyPath: keyPath) as? Bool ?? false }
        set { setValue(newValue, forKeyPath: keyPath) }
    }
}
