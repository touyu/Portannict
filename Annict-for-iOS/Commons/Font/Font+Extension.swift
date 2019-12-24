//
//  Font+Extension.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/12/20.
//

import UIKit

extension UIFont {
    enum SymbolStyle: String {
        case regular = "Symbols-Regular"
        case medium  = "Symbols-Medium"
    }

    class func symbol(ofSize size: CGFloat, weight font: SymbolStyle) -> UIFont {
        return UIFont(name: font.rawValue, size: size)!
    }
}

extension UIButton {
    convenience init(symbol: SymbolFontIcon, size: CGFloat, weight: UIFont.SymbolStyle = .regular, color: UIColor, baselineOffset: Double = 0, for state: UIControl.State = .normal) {
        self.init(type: .system)
        configure(symbol: symbol, ofSize: size, weight: weight, color: color, baselineOffset: baselineOffset, for: state)
    }

    func configure(symbol: SymbolFontIcon, ofSize size: CGFloat, weight: UIFont.SymbolStyle = .regular, color: UIColor, for state: UIControl.State = .normal) {
        setTitle(symbol.charactor, for: state)
        setTitleColor(color, for: state)
        titleLabel?.font = UIFont.symbol(ofSize: size, weight: weight)
    }

    func configure(symbol: SymbolFontIcon, ofSize size: CGFloat, weight: UIFont.SymbolStyle = .regular, color: UIColor, baselineOffset: Double, for state: UIControl.State = .normal) {
        let attr = symbol.charactor.attr
            .font(.symbol(ofSize: size, weight: weight))
            .foregroundColor(color)
            .baselineOffset(baselineOffset)
            .apply()
        titleLabel?.baselineAdjustment = .alignCenters
        titleLabel?.textAlignment = .center
        setAttributedTitle(attr, for: state)
    }

    func update(symbol: SymbolFontIcon, for state: UIControl.State = .normal) {
        setTitle(symbol.charactor, for: state)
    }
}

extension UILabel {
    func configure(symbol: SymbolFontIcon, size: CGFloat, weight: UIFont.SymbolStyle = .regular, color: UIColor, baselineOffset: Double = 0) {
        baselineAdjustment = .alignCenters
        textAlignment = .center
        attributedText = symbol.charactor.attr
            .font(.symbol(ofSize: size, weight: weight))
            .foregroundColor(color)
            .baselineOffset(baselineOffset)
            .apply()
    }
}

extension UIImage {
    static func icon(_ icon: SymbolFontIcon, ofSize size: CGFloat, weight: UIFont.SymbolStyle = .regular, color: UIColor, baselineOffset: CGFloat = 0) -> UIImage? {
        let width = size * 2
        let rect = CGSize(width: width, height: width)
        UIGraphicsBeginImageContextWithOptions(rect, false, 0)
        let font = UIFont.symbol(ofSize: size, weight: weight)
        let attributes = [NSAttributedString.Key.foregroundColor: color,
                          NSAttributedString.Key.font: font]
        let attributedString = NSAttributedString(string: icon.charactor, attributes: attributes)
        let context = NSStringDrawingContext()
        let boundingRect = attributedString.boundingRect(with: rect, options: .usesLineFragmentOrigin, context: context)
        let imageRect = CGRect(x: (rect.width / 2.0) - (boundingRect.size.width / 2.0),
                               y: (rect.height / 2.0) - (boundingRect.size.height / 2.0) - baselineOffset,
                               width: rect.width,
                               height: rect.height)
        attributedString.draw(in: imageRect)
        let iconImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return iconImage
    }
}
