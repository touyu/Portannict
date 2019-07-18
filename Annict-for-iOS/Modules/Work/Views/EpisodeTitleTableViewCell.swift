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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func configure(episode: MinimumEpisode) {
        titleLabel.text = episode.numberAndTitle
    }
}
