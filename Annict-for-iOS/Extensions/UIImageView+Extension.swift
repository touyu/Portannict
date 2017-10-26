//
//  UIImageView+Extension.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/10/14.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import Kingfisher

extension UIImageView {
    func set(url: URLConvertible?) {
        do {
            try kf.setImage(with: url?.asURL(), placeholder: #imageLiteral(resourceName: "portannict_gray_icon"), options: setImageOptions)
        } catch PError.invalidURL(let url) {
            print("ERROR: Could not convert to URL.\n\(url)")
        } catch {
            print("ERROR: Could not convert to URL.")
        }
    }
    
    private var setImageOptions: [KingfisherOptionsInfoItem] {
        let cache = ImageCache(name: "portannict_image_cache")
        cache.maxDiskCacheSize = UInt(1024 * 1024 * 1000) // 1GB
        let size = CGSize(width: bounds.width*2, height: bounds.height*2)
        let processor = ResizingImageProcessor(referenceSize: size, mode: .aspectFill)
        return [.targetCache(cache), .processor(processor)]
    }
}
