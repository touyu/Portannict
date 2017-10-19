//
//  UIColor+Extensions.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: Double = 1.0) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
    
    func brighten(by ratio: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: saturation, brightness: brightness * ratio, alpha: alpha)
        }
        return self
    }
    
    static var annictPink: UIColor {
        return UIColor(hex: 0xf85b73)
    }
    
    static var annictBlue: UIColor {
        return UIColor(hex: 0x0366d6)
    }
}
