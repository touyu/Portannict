//
//  UserProfileView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/04/01.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import Kingfisher

protocol UserProfileViewDelegate {
    func didSelectFollowingButton()
    func didSelectFollowerButton()
}

class UserProfileView: UIView {
    
    var delegate: UserProfileViewDelegate?
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var recordsLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var followerButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup(self.frame)
    }
    
    private func setup(_ frame: CGRect) {
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
        
        initUI()
        initAvatarImageView()
        initButtons()
        getMe()
    }
    
    private func initUI() {
        nameLabel.text = ""
        username.text = ""
        descriptionLabel.text = ""
        recordsLabel.text = ""
    }
    
    private func initAvatarImageView() {
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 8
    }
    
    private func initButtons() {
        let followButtonTitle = "following".localized(withTableName: "AnnictBaseLocalizable")
        followButton.setTitle(followButtonTitle, for: .normal)
        let followerButtonTitle = "follower".localized(withTableName: "AnnictBaseLocalizable")
        followerButton.setTitle(followerButtonTitle, for: .normal)
        
        followButton.layer.masksToBounds = true
        followButton.layer.cornerRadius = 4
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.white.cgColor
        
        followerButton.layer.masksToBounds = true
        followerButton.layer.cornerRadius = 4
        followerButton.layer.borderWidth = 1
        followerButton.layer.borderColor = UIColor.white.cgColor
    }
    
    private func getMe() {
        if let userData = AnnictConsts.userData {
            setData(userData: userData)
        }
        
        AnnictGraphQLClient.request(query: GetViewerQuery()) { [weak self] result, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let viewer = result?.data?.viewer else { return }
            AnnictConsts.userData = viewer
            self?.setData(userData: viewer)
        }
    }
    
    private func setData(userData: GetViewerQuery.Data.Viewer) {
        AnnictImageManager.setImage(imageView: avatarImageView, url: userData.avatarUrl)
        AnnictImageManager.setImage(imageView: backgroundImageView, url: userData.backgroundImageUrl)
        
        nameLabel.text = userData.name
        username.text = "@ \(userData.username)"
        descriptionLabel.text = userData.description
        recordsLabel.text = "\(userData.recordsCount) Records"
        
        let followButtonTitle = "\(AnnictConsts.userData?.followingsCount ?? 0) " + "following".localized(withTableName: "AnnictBaseLocalizable")
        followButton.setTitle(followButtonTitle, for: .normal)
        let followerButtonTitle = "\(AnnictConsts.userData?.followersCount ?? 0) " + "follower".localized(withTableName: "AnnictBaseLocalizable")
        followerButton.setTitle(followerButtonTitle, for: .normal)
    }
    
    @IBAction func tappedFollowingButton(_ sender: UIButton) {
        delegate?.didSelectFollowingButton()
    }
    
    @IBAction func tappedFollowerButton(_ sender: UIButton) {
        delegate?.didSelectFollowerButton()
    }
}
