//
//  UIView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

extension UIView {

    func circleFilter() {
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }

    func roundedRectangleFilter() {
        layer.cornerRadius = frame.size.height / 2
        layer.masksToBounds = true
    }

    func removeAll() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
        removeFromSuperview()
    }

    func applyShadow(color: UIColor = .black,
                     opacity: Float = 0.16,
                     radius: CGFloat = 16,
                     offset: CGSize = .init(width: 0, height: 3),
                     path: UIBezierPath? = nil,
                     shouldRasterize: Bool = true) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shouldRasterize = shouldRasterize
        layer.rasterizationScale = UIScreen.main.scale

        if let path = path {
            layer.shadowPath = path.cgPath
        } else {
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        }
    }

    func updateShodowPath() {
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
