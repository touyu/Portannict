//
//  Ornament.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/28.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

extension UIView {
    enum Ornament {
        case workImage
    }
    
    func apply(_ ornament: Ornament) {
        switch ornament {
        case .workImage:
            applyWorkOrnament()
        }
    }
    
    private func applyWorkOrnament() {
        applyCornerRadius(12)
        applyBorder(color: UIColor(white: 0.9, alpha: 1), width: 0.4)
    }
    
    private func applyCornerRadius(_ radius: CGFloat, masksToBounds: Bool = true) {
        layer.cornerRadius = radius
        layer.masksToBounds = masksToBounds
    }
    
    private func applyBorder(color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}

