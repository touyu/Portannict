//
//  ActivityStatusTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/03/12.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class ActivityStatusTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var workQuoteView: WorkQuoteView!

    override func awakeFromNib() {
        super.awakeFromNib()

        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 40 / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        workQuoteView.backgroundColor = .white
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        workQuoteView.backgroundColor = .white
    }

    func configure(activityItem: HomeViewReactor.Activity.AsStatus, heroID: String?) {
        let user = activityItem.user.fragments.minimumUser
        avatarImageView.setImage(url: user.avatarUrl)
        nameLabel.text = user.name
        usernameLabel.text = "@" + user.username
        let work = activityItem.work.fragments.minimumWork
        workQuoteView.configure(work: work)
        messageLabel.text = "ステータスを「\(activityItem.state.localizedText)」に変更しました。"
        timeLabel.text = activityItem.createdAt.toDate()?.toRelative()
        
        if let heroID = heroID {
            workQuoteView.workImageView.hero.id = heroID
        }
    }
}
