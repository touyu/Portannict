//
//  RatingStateView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/10/19.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class RatingStateView: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    var statusState: RatingState? {
        didSet {
            text = statusState?.localized()
            backgroundColor = statusState?.color
        }
    }
    
    private let padding: CGFloat = 4
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding*2,
                      height: size.height + padding)
    }
    
    override func drawText(in rect: CGRect) {
        let rect = rect.insetBy(dx: padding, dy: padding/2)
        super.drawText(in: rect)
    }
    
    private func commonInit() {
        layer.masksToBounds = true
        layer.cornerRadius = 4
        font = .systemFont(ofSize: 12)
        textColor = .white
    }
}
