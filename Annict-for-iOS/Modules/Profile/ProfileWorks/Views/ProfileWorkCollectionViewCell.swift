//
//  ProfileWorkCollectionViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/01/16.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

class ProfileWorkCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var workImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        workImageView.apply(.workImage)
    }

    func configure(work: MinimumWork) {
        workImageView.setImage(url: work.image?.url)
        titleLabel.text = work.title
    }
    
    func setHeroID(_ heroID: String) {
        workImageView.hero.id = heroID
        workImageView.hero.modifiers = [.spring(stiffness: 250, damping: 25),
                                        .duration(0.3)]
    }
}
