//
//  WorkHeaderView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/02/02.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class WorkHeaderView: UIView, NibOwnerLoadable {
    @IBOutlet weak var workImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var reviewsCount: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    
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
        statusButton.roundedRectangleFilter()
        statusButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        workImageView.apply(.workImage)
        workImageView.hero.modifiers = [.spring(stiffness: 250, damping: 25),
                                        .duration(0.3)]
    }
    
    func configure(work: MinimumWork) {
        workImageView.setImage(url: work.image?.url)
        titleLabel.text = work.title
        watchersCountLabel.text = work.watchersCount.description
        reviewsCount.text = work.reviewsCount.description
        statusButton.setTitle("見てる", for: .normal)
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
