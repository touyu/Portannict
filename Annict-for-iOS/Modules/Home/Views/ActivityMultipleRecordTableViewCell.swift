//
//  ActivityMultipleRecordTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/03/12.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class ActivityMultipleRecordTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
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

    func configure(activityItem: HomeViewReactor.Activity.AsMultipleRecord, heroID: String? = nil) {
        let user = activityItem.user.fragments.minimumUser
        avatarImageView.setImage(url: user.avatarUrl)
        nameLabel.text = user.name
        let work = activityItem.work.fragments.minimumWork
        workQuoteView.configure(work: work)
        prepareMessageLabel(activityItem: activityItem)
        
        if let heroID = heroID {
            workQuoteView.workImageView.hero.id = heroID
        }
    }

    private func prepareMessageLabel(activityItem: HomeViewReactor.Activity.AsMultipleRecord) {
        let episodes = activityItem.records?.nodes?.compactMap { $0?.episode.fragments.minimumEpisode }
        guard let minEpisode = episodes?.min(by: { $0.sortNumber < $1.sortNumber })?.numberText else {
            messageLabel.text = "\(activityItem.work.fragments.minimumWork.title)を見ました。"
            return
        }
        guard let maxEpisode = episodes?.max(by: { $0.sortNumber < $1.sortNumber })?.numberText else {
            messageLabel.text = "\(activityItem.work.fragments.minimumWork.title)を見ました。"
            return
        }
        messageLabel.text = "\(minEpisode)から\(maxEpisode)を見ました。"
    }
}
