//
//  UIImageView+Extension.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/10/14.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

extension UIImageView {
    func set(url: String?) {
        if let urlString = url, let url = URL(string: urlString) {
            kf.setImage(with: url)
        }
    }
}
