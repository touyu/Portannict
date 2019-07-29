//
//  UserInfoTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/14.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import Kingfisher

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var recordsCountLabel: UILabel!
    @IBOutlet private weak var followingCountLable: UILabel!
    @IBOutlet private weak var followersCountLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareUI()
    }
    
    func prepare(user: GetViewerInfoQuery.Data.Viewer) {
        nameLabel.text = user.name
        usernameLabel.text = "@\(user.username)"
        avatarImageView.setImage(url: user.avatarUrl)
        recordsCountLabel.text = "\(user.recordsCount)"
        followingCountLable.text = "\(user.followingsCount)"
        followersCountLabel.text = "\(user.followersCount)"
        descriptionLabel.attributedText = makeDescriptionText(string: user.description)
    }
    
    private func prepareUI() {
        recordsCountLabel.text = "\(0)"
        followingCountLable.text = "\(0)"
        followersCountLabel.text = "\(0)"
        
        avatarImageView.circleFilter()
        avatarImageView.layer.borderWidth = 0.4
        avatarImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func makeDescriptionText(string: String) -> NSAttributedString {
        return NSAttributedString(string: string,
                                  attributes: [
                                    .paragraphStyle: NSMutableParagraphStyle(lineSpacing: 10.0)
                                  ])
    }
}
