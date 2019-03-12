//
//  ActivityRecordTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/03/12.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class ActivityRecordTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var workAndEpisodeQuoteView: WorkAndEpisodeQuoteView!

    override func awakeFromNib() {
        super.awakeFromNib()

        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 40 / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        workAndEpisodeQuoteView.backgroundColor = .white
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        workAndEpisodeQuoteView.backgroundColor = .white
    }

    func configure(activityItem: HomeViewReactor.Activity.AsRecord) {
        let user = activityItem.user.fragments.minimumUser
        avatarImageView.setImage(url: user.avatarUrl)
        nameLabel.text = user.name
        messageLabel.text = activityItem.comment
        workAndEpisodeQuoteView.configure(work: activityItem.work.fragments.minimumWork,
                                          episode: activityItem.episode.fragments.minimumEpisode)
    }
}
