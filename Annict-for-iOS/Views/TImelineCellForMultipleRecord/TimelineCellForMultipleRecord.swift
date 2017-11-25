//
//  TimelineCellForMultipleRecord.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/11/25.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class TimelineCellForMultipleRecord: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    private var _activity: FollowingActivity.AsMultipleRecord? {
        didSet {
            guard let activity = _activity else { return }
            
            avatarImageView.set(url: activity.user.avatarUrl)
            nameLabel.text = activity.user.name
            usernameLabel.text = "@\(activity.user.username)"
            timeLabel.text = activity.createdAt.toDate().timeAgoSinceNow
        }
    }
    
    func set(activity: FollowingActivity.AsMultipleRecord?) {
        _activity = activity
    }
}
