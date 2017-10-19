//
//  RecordCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/05/31.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {
    
    var record: AnnictRecordResponse? {
        get {
            return setedRecord
        }
    }
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ratingStateView: OldRatingStateView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    fileprivate var setedRecord: AnnictRecordResponse?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        ratingStateView.backgroundColor = ratingStateView.state?.color
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        ratingStateView.backgroundColor = ratingStateView.state?.color
    }
    
    func set(record: AnnictRecordResponse) {
        setedRecord = record
        nameLabel.text = record.user?.name
        if let username = record.user?.username {
            usernameLabel.text = "@\(username)"
        } else {
            usernameLabel.text = ""
        }
        commentLabel.text = record.comment
        initUI()
        initTimeLabel(createdAt: record.createdAt)
        
        AnnictImageManager.setAvatarImage(imageView: avatarImageView, user: record.user)
        
        if let ratingState = record.ratingState {
            ratingStateView.set(ratingState: ratingState)
        }
    }
    
    private func initUI() {
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 4
    }
    
    private func initTimeLabel(createdAt: String?) {
        guard let createdAt = createdAt else { return }
        let date = Date(dateString: createdAt, format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        timeLabel.text = date.timeAgoSinceNow
    }
}
