//
//  WorkTitleTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/12/05.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

final class WorkTitleTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        clearSeparator()
    }

    func configure(title: String?, titleLabelHeroID: String) {
        titleLabel.text = title
        titleLabel.hero.id = titleLabelHeroID
    }
    
}
