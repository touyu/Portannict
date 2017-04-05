//
//  AnnictImageManager.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/04/05.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import Kingfisher


class AnnictImageManager {
    
    class func setImage(imageView: UIImageView!, imageURL: URL?) {
        guard let url = imageURL else { return }
        imageView.kf.setImage(with: url)
    }
}
