//
//  UIColor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/25.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(hex: NSInteger, alpha: CGFloat = 1) {
        let r: Int = (hex >> 16)
        let g: Int = (hex >> 8 & 0xFF)
        let b: Int = (hex & 0xFF)
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha)
    }
}
