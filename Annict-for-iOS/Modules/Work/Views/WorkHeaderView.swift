//
//  WorkHeaderView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/02/02.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class WorkHeaderView: UIView, NibOwnerLoadable {
    @IBOutlet weak var blurWorkImageView: UIImageView!
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
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == statusButton {
            return view
        }
        return nil
    }
    
    private func commonInit() {
        loadNib()
        statusButton.roundedRectangleFilter()
        statusButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        workImageView.layer.cornerRadius = 8
        workImageView.layer.masksToBounds = true
        workImageView.hero.modifiers = [.spring(stiffness: 250, damping: 25),
                                        .duration(0.3)]
    }
    
    func configure(work: MinimumWork) {
        blurWorkImageView.setImage(url: work.image?.url)
        blurWorkImageView.bk.addBlur(blurRadius: 24, colorTint: .white, colorTintAlpha: 0.2)
        workImageView.setImage(url: work.image?.url)
        titleLabel.text = work.title
        watchersCountLabel.text = work.watchersCount.description
        reviewsCount.text = work.reviewsCount.description
        let statusText = work.viewerStatusState?.localizedText
//        statusButton.titleLabel?.text = statusText
        statusButton.setTitle(statusText, for: .normal)
        statusButton.layoutIfNeeded()
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
