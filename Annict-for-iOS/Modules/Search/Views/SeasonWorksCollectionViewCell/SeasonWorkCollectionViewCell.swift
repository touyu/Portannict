//
//  SeasonWorkCollectionViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/01/18.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class SeasonWorkCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var workImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var statusLabel: PaddingLabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        workImageView.apply(.workImage)
        statusLabel.layer.cornerRadius = 4
        statusLabel.layer.masksToBounds = true
    }

    func configure(work: MinimumWork) {
        workImageView.setImage(workID: work.annictId)
        titleLabel.text = work.title

        if let state = work.viewerStatusState {
            switch state {
            case .wannaWatch, .watching, .watched, .onHold, .stopWatching:
                statusLabel.isHidden = false
                statusLabel.text = state.localizedText
            default:
                statusLabel.isHidden = true
            }
        }

    }

    func setColumnCount(_ count: Int) {
        if count == 2 {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        }

        if count == 3 {
            titleLabel.font = UIFont.systemFont(ofSize: 11)
        }
    }
}
