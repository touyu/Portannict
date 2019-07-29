//
//  NSMutableParagraphStyle.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/25.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

public extension NSMutableParagraphStyle {
    
    public convenience init(lineSpacing: CGFloat? = nil, lineBreakMode: NSLineBreakMode? = nil, alignment: NSTextAlignment? = nil, lineHeight: CGFloat? = nil, firstLineHeadIndent: CGFloat? = nil, headIndent: CGFloat? = nil, tailIndent: CGFloat? = nil) {
        self.init()
        
        if let lineSpacing = lineSpacing {
            self.lineSpacing = lineSpacing
        }
        if let lineBreakMode = lineBreakMode {
            self.lineBreakMode = lineBreakMode
        }
        if let alignment = alignment {
            self.alignment = alignment
        }
        if let lineHeight = lineHeight {
            self.minimumLineHeight = lineHeight
            self.maximumLineHeight = lineHeight
        }
        
        if let firstLineHeadIndent = firstLineHeadIndent {
            self.firstLineHeadIndent = firstLineHeadIndent
        }
        
        if let headIndent = headIndent {
            self.headIndent = headIndent
        }
        
        if let tailIndent = tailIndent {
            self.tailIndent = tailIndent
        }
    }
}
