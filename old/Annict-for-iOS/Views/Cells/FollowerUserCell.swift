//
//  FollowerUserCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/06/15.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class FollowerUserCell: UITableViewCell {
    
    @IBOutlet dynamic private weak var avatarImageView: UIImageView!
    @IBOutlet dynamic private weak var nameLabel: UILabel!
    @IBOutlet dynamic private weak var usernameLabel: UILabel!
    @IBOutlet dynamic private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
    
    private func initUI() {
        nameLabel.text = ""
        usernameLabel.text = ""
        descriptionLabel.text = ""
        
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 4
    }
    
    func set(user: GetViewerFollowersQuery.Data.Viewer.Follower.Edge.Node) {
        AnnictImageManager.setImage(imageView: avatarImageView, url: user.avatarUrl)
        
        nameLabel.text = user.name
        usernameLabel.text = "@\(user.username)"
        descriptionLabel.text = user.description
    }
}
