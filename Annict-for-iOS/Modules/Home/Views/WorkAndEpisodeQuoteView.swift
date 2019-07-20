//
//  WorkAndEpisodeQuoteView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/03/12.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class WorkAndEpisodeQuoteView: UIView, NibOwnerLoadable {
    @IBOutlet private(set) weak var workImageView: UIImageView!
    @IBOutlet private weak var workTitleLabel: UILabel!
    @IBOutlet private weak var episodeLabel: UILabel!

    override var intrinsicContentSize: CGSize {
        return CGSize(width: CGFloat.greatestFiniteMagnitude, height: 60)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        loadNib()

        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.borderColor = UIColor(hex: 0xE2E2E2).cgColor
        layer.borderWidth = 0.5
        
        workImageView.layer.cornerRadius = 8
        workImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }

    func configure(work: MinimumWork, episode: MinimumEpisode) {
        workImageView.setImage(workID: work.annictId)
        workTitleLabel.text = work.title
        episodeLabel.text = "\(episode.numberAndTitle)"
    }
}

extension MinimumWork.Image {
    var url: String? {
        if let twitterAvatarUrl = twitterAvatarUrl, !twitterAvatarUrl.isEmpty {
            return twitterAvatarUrl
        }
        
        if let recommendedImageUrl = recommendedImageUrl {
            return recommendedImageUrl.replacingOccurrences(of: "http://", with: "https://")
        }
        
        return nil
    }
}
