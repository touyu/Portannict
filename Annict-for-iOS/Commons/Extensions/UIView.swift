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
}
