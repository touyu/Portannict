//
//  PaddingLabel.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/26.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {

    var padding = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8) {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override func drawText(in rect: CGRect) {
        let newRect = rect.inset(by: padding)
        super.drawText(in: newRect)
    }

    override var intrinsicContentSize: CGSize {
        var intrinsicContentSize = super.intrinsicContentSize
        intrinsicContentSize.height += padding.top + padding.bottom
        intrinsicContentSize.width += padding.left + padding.right
        return intrinsicContentSize
    }
}
