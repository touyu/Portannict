//
//  UINavigationBar.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/30.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

public extension UINavigationBar {

    public func clearShadowLine(color: UIColor? = nil) {
        if let color = color {
            let image = UIImage.make(size: CGSize(width: 300, height: 100), color: color)
            self.setBackgroundImage(image, for: .default)
        } else {
            self.setBackgroundImage(nil, for: .default)
        }
        self.shadowImage = UIImage()
    }

    public func transparent() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
    }

    public func untransparent() {
        self.setBackgroundImage(nil, for: .default)
        self.shadowImage = nil
    }
}
