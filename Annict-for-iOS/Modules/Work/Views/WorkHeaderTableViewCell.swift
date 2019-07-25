//
//  WorkHeaderTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/19.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import SQLite

final class WorkHeaderTableViewCell: UITableViewCell {

    @IBOutlet private weak var blurWorkImageView: UIImageView!
    @IBOutlet private weak var workImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var statusButton: WorkStatusButton!

    var didTapButton: (() -> Void)?
    var didTapDetail: (() -> Void)?
    weak var delegate: WorkStatusButtonDelegate? {
        didSet {
            statusButton.delegate = delegate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        workImageView.layer.cornerRadius = 6
        workImageView.layer.masksToBounds = true
        
        blurWorkImageView.layer.masksToBounds = true
        blurWorkImageView.bk.addBlur(blurRadius: 24, colorTint: .white, colorTintAlpha: 0.2)
        statusButton.roundedRectangleFilter()
    }
    
    func configure(work: MinimumWork) {
        workImageView.setImage(workID: work.annictId)
        blurWorkImageView.setImage(workID: work.annictId)
        titleLabel.text = work.title
        statusButton.configure(status: work.viewerStatusState ?? .noState)
        statusButton.didTap = didTapButton
        statusButton.didTapDetail = didTapDetail
    }
}
