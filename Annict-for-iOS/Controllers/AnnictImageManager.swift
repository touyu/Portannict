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
    
    class func setAvatarImage(imageView: UIImageView, user: AnnictUserResponse?) {
        guard let avatarImageURL = user?.avatarURL else {
            imageView.image = placeholderImage
            return
        }
        
        imageView.kf.setImage(with: avatarImageURL, placeholder: placeholderImage)
    }
    
    class func setWorkImage(imageView: UIImageView!, work: AnnictWorkResponse?) {
        guard let work = work else {
            imageView.image = defaultImage
            return
        }
        
        if let twitterImageURL = work.images?.twitter?.originalAvatarURL {
            setImage(imageView: imageView, imageURL: twitterImageURL)
        } else if let recommendedURL = work.images?.recommendedURL {
            setImage(imageView: imageView, imageURL: recommendedURL)
        } else {
            imageView.image = defaultImage
        }
    }
    
    private static let defaultImage = #imageLiteral(resourceName: "annict_icon")
    private static let placeholderImage = #imageLiteral(resourceName: "light_gray_image")
    
    class private func setImage(imageView: UIImageView!, imageURL: URL?) {
        guard let url = imageURL else { return }
        imageView.kf.setImage(with: url, placeholder: placeholderImage, completionHandler: { image, error, _, _ in
            if let _ = error {
                imageView.image = defaultImage
            }
        })
    }
}
