//
//  EpisodeRecordTitleTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/25.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class EpisodeRecordTitleTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configure(title: String) {
        titleLabel.text = title
    }
}
