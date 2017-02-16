//
//  AnnictEpisodeCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/12.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class AnnictEpisodeCell: UITableViewCell {
    
    @IBOutlet dynamic fileprivate weak var countLabel: UILabel!
    @IBOutlet dynamic fileprivate weak var titleLabel: UILabel!
    
    func set(episode: AnnictEpisodeResponse) {
        self.countLabel.text = episode.numberText ?? ""
        self.titleLabel.text = episode.title ?? "No Title"
    }
}
