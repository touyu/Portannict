//
//  SeasonWorkCollectionViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/01/18.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class SeasonWorkCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
    }

    func configure(url: String?) {
        imageView.setImage(url: url)
    }
}
