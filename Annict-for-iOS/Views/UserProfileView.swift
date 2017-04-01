//
//  UserProfileView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/04/01.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import Kingfisher


class UserProfileView: UIView {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup(self.frame)
    }
    
    fileprivate func setup(_ frame: CGRect) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: UserProfileView.self), bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            self.addSubview(view)
            
            // カスタムViewのサイズを自分自身と同じサイズにする
            view.translatesAutoresizingMaskIntoConstraints = false
            let bindings = ["view": view]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                          options:NSLayoutFormatOptions(rawValue: 0),
                                                          metrics:nil,
                                                          views: bindings))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                          options:NSLayoutFormatOptions(rawValue: 0),
                                                          metrics:nil,
                                                          views: bindings))
        }
        
        self.initAvatarImageView()
        self.getMe()
    }
    
    fileprivate func initAvatarImageView() {
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 8
    }
    
    fileprivate func getMe() {
        let request = AnnictAPI.GetMe()
        AnnictAPIClient.send(request) { [weak self] response in
            switch response {
            case .success(let value):
                if let urlString = value.avatarURL, let url = URL(string: urlString) {
                    self?.avatarImageView.kf.setImage(with: url)
                }
                
                if let backgroundImageURLString = value.backgroundImageURL, let backgroundImageURL = URL(string: backgroundImageURLString) {
                    self?.backgroundImageView.kf.setImage(with: backgroundImageURL)
                }
                
                self?.nameLabel.text = value.name
                
                if let username = value.username {
                    self?.username.text = "@" + username
                }
                
                self?.descriptionLabel.text = value.description
            case .failure(let error):
                print(error)
            }
        }
    }
}
