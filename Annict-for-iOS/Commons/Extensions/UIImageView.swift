//
//  UIImageView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/25.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: URLConvertible?, completion: ((UIImage?) -> Void)? = nil) {
        let downloader = ImageDownloader.default
        downloader.downloadTimeout = 300
        kf.setImage(with: url?.asURL(),
                    placeholder: UIImage.make(color: UIColor(white: 0.9, alpha: 1)),
                    options: [.transition(.fade(0.4)),
                              .downloader(downloader)],
                    completionHandler: { img, error, _, url in
                        completion?(img)
        })
    }
}
