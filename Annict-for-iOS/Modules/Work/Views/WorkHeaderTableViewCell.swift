//
//  WorkHeaderTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/19.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class WorkHeaderTableViewCell: UITableViewCell {

    @IBOutlet private weak var blurWorkImageView: UIImageView!
    @IBOutlet private weak var workImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var statusButton: WorkStatusButton!

    var didTapDetail: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        workImageView.layer.cornerRadius = 16
        workImageView.layer.masksToBounds = true
        
        blurWorkImageView.layer.masksToBounds = true
        blurWorkImageView.bk.addBlur(blurRadius: 24, colorTint: .white, colorTintAlpha: 0.2)
        statusButton.roundedRectangleFilter()
    }
    
    func configure(work: MinimumWork) {
        workImageView.setImage(url: work.image?.url)
        blurWorkImageView.setImage(url: work.image?.url)
        titleLabel.text = work.title
        statusButton.configure(status: work.viewerStatusState ?? .noState)
        statusButton.didTapDetail = didTapDetail
    }
}
