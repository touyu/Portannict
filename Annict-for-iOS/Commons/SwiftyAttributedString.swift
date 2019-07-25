//
//  SwiftyAttributedString.swift
//  SwiftyAttributedString
//
//  Created by Yuto Akiba on 2018/12/17.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

public struct SwiftyAttributedString {
    private let attributedString: NSMutableAttributedString
    private let range: NSRange

    public  init(attributedString: NSMutableAttributedString, range: NSRange) {
        self.attributedString = attributedString
        self.range = range
    }

    public func apply() -> NSMutableAttributedString {
        return attributedString
    }

    public func range(_ range: NSRange, handler: (SwiftyAttributedString) -> Void) -> SwiftyAttributedString {
        let swiftyAttributedString = SwiftyAttributedString(attributedString: attributedString, range: range)
        handler(swiftyAttributedString)
        return self
    }

    public func range(of word: String, handler: (SwiftyAttributedString) -> Void) -> SwiftyAttributedString {
        let r = (attributedString.string as NSString).range(of: word)
        return range(r, handler: handler)
    }

    public func range(location: Int, length: Int, handler: (SwiftyAttributedString) -> Void) -> SwiftyAttributedString {
        return range(NSRange(location: location, length: length), handler: handler)
    }

    public func range(start: Int, end: Int, handler: (SwiftyAttributedString) -> Void) -> SwiftyAttributedString {
        return range(location: start, length: end - start + 1, handler: handler)
    }

    @discardableResult
    public func font(_ font: UIFont) -> SwiftyAttributedString {
        attributedString.addAttributes([.font: font], range: range)
        return self
    }

    @discardableResult
    public func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> SwiftyAttributedString {
        attributedString.addAttributes([.paragraphStyle: paragraphStyle], range: range)
        return self
    }

    @discardableResult
    public func lineSpacing(_ lineSpacing: CGFloat) -> SwiftyAttributedString {
        let s = NSMutableParagraphStyle()
        s.lineSpacing = lineSpacing
        attributedString.addAttributes([.paragraphStyle: s], range: range)
        return self
    }

    @discardableResult
    public func foregroundColor(_ color: UIColor) -> SwiftyAttributedString {
        attributedString.addAttributes([.foregroundColor: color], range: range)
        return self
    }

    @discardableResult
    public func backgroundColor(_ color: UIColor) -> SwiftyAttributedString {
        attributedString.addAttributes([.backgroundColor: color], range: range)
        return self
    }

    @discardableResult
    public func ligature(_ ligature: NSNumber) -> SwiftyAttributedString {
        attributedString.addAttributes([.ligature: ligature], range: range)
        return self
    }

    @discardableResult
    public func kern(_ kern: Double) -> SwiftyAttributedString {
        attributedString.addAttributes([.kern: kern], range: range)
        return self
    }

    @discardableResult
    public func strikethroughStyle(_ strikethroughStyle: NSUnderlineStyle) -> SwiftyAttributedString {
        attributedString.addAttributes([.strikethroughStyle: strikethroughStyle.rawValue], range: range)
        return self
    }

    @discardableResult
    public func underlineStyle(_ underlineStyle: NSUnderlineStyle) -> SwiftyAttributedString {
        attributedString.addAttributes([.underlineStyle: underlineStyle.rawValue], range: range)
        return self
    }

    @discardableResult
    public func strokeColor(_ color: UIColor) -> SwiftyAttributedString {
        attributedString.addAttributes([.strokeColor: color], range: range)
        return self
    }

    @discardableResult
    public func strokeWidth(_ width: Double) -> SwiftyAttributedString {
        attributedString.addAttributes([.strokeWidth: width], range: range)
        return self
    }

    @discardableResult
    public func shadow(_ shadow: NSShadow) -> SwiftyAttributedString {
        attributedString.addAttributes([.shadow: shadow], range: range)
        return self
    }

    @discardableResult
    public func textEffect(_ textEffect: NSString) -> SwiftyAttributedString {
        attributedString.addAttributes([.textEffect: textEffect], range: range)
        return self
    }

    @discardableResult
    public func attachment(_ attachment: NSTextAttachment) -> SwiftyAttributedString {
        attributedString.addAttributes([.attachment: attachment], range: range)
        return self
    }

    @discardableResult
    public func link(_ link: URL) -> SwiftyAttributedString {
        attributedString.addAttributes([.link: link], range: range)
        return self
    }

    @discardableResult
    public func baselineOffset(_ offset: Double) -> SwiftyAttributedString {
        attributedString.addAttributes([.baselineOffset: offset], range: range)
        return self
    }

    @discardableResult
    public func underlineColor(_ color: UIColor) -> SwiftyAttributedString {
        attributedString.addAttributes([.underlineColor: color], range: range)
        return self
    }

    @discardableResult
    public func strikethroughColor(_ color: UIColor) -> SwiftyAttributedString {
        attributedString.addAttributes([.strikethroughColor: color], range: range)
        return self
    }

    @discardableResult
    public func obliqueness(_ obliqueness: Double) -> SwiftyAttributedString {
        attributedString.addAttributes([.obliqueness: obliqueness], range: range)
        return self
    }

    @discardableResult
    public func expansion(_ expansion: Double) -> SwiftyAttributedString {
        attributedString.addAttributes([.expansion: expansion], range: range)
        return self
    }

    @discardableResult
    public func writingDirection(_ writingDirection: NSArray) -> SwiftyAttributedString {
        attributedString.addAttributes([.writingDirection: writingDirection], range: range)
        return self
    }

    @discardableResult
    public func verticalGlyphForm(_ verticalGlyphForm: Int) -> SwiftyAttributedString {
        attributedString.addAttributes([.verticalGlyphForm: verticalGlyphForm], range: range)
        return self
    }
}

extension String {
    public var attr: SwiftyAttributedString {
        let range = (self as NSString).range(of: self)
        let attrStr = NSMutableAttributedString(string: self)
        return SwiftyAttributedString(attributedString: attrStr, range: range)
    }
}
