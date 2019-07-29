//
//  EpisodeRecordTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/25.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class EpisodeRecordTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var statusTagView: RecordStatusTagView!
    @IBOutlet private weak var commentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.circleFilter()
    }
    
    func configure(record: MinimumRecord) {
        let user = record.user.fragments.minimumUser
        avatarImageView.setImage(url: user.avatarUrl)
        nameLabel.text = user.name
        usernameLabel.text = user.username
        timeLabel.text = record.createdAt.toDate()?.toRelativeCurrentLocal()
        commentLabel.text = record.comment
        if let ratingState = record.ratingState {
            statusTagView.isHidden = false
            statusTagView.configure(ratingState: ratingState)
        } else {
            statusTagView.isHidden = true
        }
    }
}
