//
//  UIImage.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/25.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

extension UIImage {
    static func make(size: CGSize = .one, color: UIColor) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        let contextRef = UIGraphicsGetCurrentContext()
        contextRef?.setFillColor(color.cgColor)
        contextRef?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return img
    }
}
