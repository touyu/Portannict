//
//  NSObject.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import Foundation

public extension NSObject {

    class var className: String {
        return String(describing: self)
    }

    var className: String {
        return String(describing: type(of: self))
    }
}
