//
//  UserInfoTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/14.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareUI()
    }
    
    func prepare(user: GetViewerInfoQuery.Data.Viewer) {
        nameLabel.text = user.name
        usernameLabel.text = "@\(user.username)"
    }
    
    private func prepareUI() {
        avatarImageView.circleFilter()
    }
}
