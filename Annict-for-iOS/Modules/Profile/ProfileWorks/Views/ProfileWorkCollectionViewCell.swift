//
//  ProfileWorkCollectionViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/01/16.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

class ProfileWorkCollectionViewCell: UICollectionViewCell {
    typealias Work = GetViewerWorksQuery.Data.Viewer.Work.Node

    @IBOutlet private weak var workImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        workImageView.apply(.workImage)
    }

    func configure(work: Work) {
        workImageView.setImage(url: work.image?.url)
        titleLabel.text = work.title
    }
}
