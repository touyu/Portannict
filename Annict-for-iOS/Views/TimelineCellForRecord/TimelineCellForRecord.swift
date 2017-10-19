//
//  TimelineCellForRecord.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/10/19.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class TimelineCellForRecord: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    private var _activity: FollowingActivity.AsRecord? {
        didSet {
            guard let activity = _activity else { return }
            
            avatarImageView.set(url: activity.user.avatarUrl)
            nameLabel.text = activity.user.name
            usernameLabel.text = "@\(activity.user.username)"
            timeLabel.text = activity.createdAt.toDate().timeAgoSinceNow
            initMessageLabel()
        }
    }
    
    func set(activity: FollowingActivity.AsRecord?) {
        _activity = activity
    }
    
    private func initMessageLabel() {
        guard let activity = _activity else { return }
        
        let title = activity.work.title
        if let episodeNumber = activity.episode.number {
            messageLabel.text = "\(title) 第\(episodeNumber)話を見ました。"
        } else {
            messageLabel.text = "\(title) を見ました。"
        }
    }
}
