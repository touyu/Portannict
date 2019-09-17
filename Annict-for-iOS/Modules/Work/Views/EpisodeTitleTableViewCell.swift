//
//  EpisodeTitleTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/19.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class EpisodeTitleTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        countLabel.roundedRectangleFilter()
        countLabel.backgroundColor = UIColor(hex: 0xEBEBEB)
        titleLabel.textColor = UIColor(hex: 0x464646)
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        countLabel.backgroundColor = UIColor(hex: 0xEBEBEB)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        countLabel.backgroundColor = UIColor(hex: 0xEBEBEB)
    }
    
    func configure(episode: MinimumEpisode) {
        titleLabel.text = episode.numberAndTitle
        countLabel.text = "\(episode.viewerRecordsCount)"
    }
}
