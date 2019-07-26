//
//  EpisodeCountSectionTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/27.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class EpisodeCountSectionTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var countLabel: PaddingLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        countLabel.padding = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
        countLabel.layoutIfNeeded()
        countLabel.roundedRectangleFilter()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        countLabel.roundedRectangleFilter()
    }
    
    func configure(episodeCount: Int) {
        countLabel.text = episodeCount.description
    }
}
