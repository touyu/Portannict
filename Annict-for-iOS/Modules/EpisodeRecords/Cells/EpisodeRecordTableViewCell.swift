//
//  EpisodeRecordTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/25.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

protocol EpisodeRecordTableViewCellDelegate: class {
    func didTapUnderArrowButton(record: MinimumRecord)
}

final class EpisodeRecordTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var statusTagView: RecordStatusTagView!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var underArrowButton: UIButton!
    
    weak var delegate: EpisodeRecordTableViewCellDelegate?
    private var record: MinimumRecord?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.circleFilter()
        underArrowButton.withImageRenderingMode(.alwaysTemplate)
        underArrowButton.tintColor = UIColor(white: 0.9, alpha: 1)
    }
    
    func configure(record: MinimumRecord) {
        self.record = record
        let user = record.user.fragments.minimumUser
        avatarImageView.setImage(url: user.avatarUrl)
        nameLabel.text = user.name
        usernameLabel.text = user.username
        if let time = record.createdAt.toDate()?.toRelativeCurrentLocal() {
            timeLabel.text = "・" + time
        }
        commentLabel.text = record.comment
        if let ratingState = record.ratingState {
            statusTagView.isHidden = false
            statusTagView.configure(ratingState: ratingState)
        } else {
            statusTagView.isHidden = true
        }
    }
    
    @IBAction func tappedUnderArrow(_ sender: UIButton) {
        guard let record = record else { return }
        delegate?.didTapUnderArrowButton(record: record)
    }
}

extension UIButton {
    func withImageRenderingMode(_ mode: UIImage.RenderingMode) {
        guard let img = imageView?.image?.withRenderingMode(mode) else { return }
        setImage(img, for: .normal)
        setImage(img, for: .selected)
    }
}
