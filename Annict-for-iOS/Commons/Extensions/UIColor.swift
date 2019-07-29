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

extension UIColor: MonoExtensionCompatible { }

// Mono

extension MonoExtension where T: UIColor {
    static var white: UIColor { return UIColor(hex: 0x000000) }
    static var monoFA: UIColor { return UIColor(hex: 0xFAFAFA) }
    static var monoF4: UIColor { return UIColor(hex: 0xF4F4F4) }
    static var monoE2: UIColor { return UIColor(hex: 0xE2E2E2) }
    static var monoDE: UIColor { return UIColor(hex: 0xDEDEDE) }
    static var monoC6: UIColor { return UIColor(hex: 0xC6C6C6) }
    static var monoB3: UIColor { return UIColor(hex: 0xB3B3B3) }
    static var mono9A: UIColor { return UIColor(hex: 0x9A9A9A) }
    static var mono72: UIColor { return UIColor(hex: 0x727272) }
    static var black: UIColor { return UIColor(hex: 0x242424) }
}

public class MonoExtension<T> {
    public let base: T
    public init(_ base: T) {
        self.base = base
    }
}

protocol MonoExtensionCompatible {
    associatedtype Compatible
    static var mono: MonoExtension<Compatible>.Type { get }
    var mono: MonoExtension<Compatible> { get }
}

extension MonoExtensionCompatible {
    public static var mono: MonoExtension<Self>.Type {
        return MonoExtension<Self>.self
    }
    
    public var mono: MonoExtension<Self> {
        return MonoExtension(self)
    }
}

extension UIColor: PortannictExtensionCompatible { }
extension PortannictExtension where T: UIColor {
    static var pink: UIColor {
        return UIColor(hex: 0xFA5871)
    }

    static var blue: UIColor {
        return UIColor(hex: 0x3498db)
    }
}
