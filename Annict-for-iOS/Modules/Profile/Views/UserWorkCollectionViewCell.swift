//
//  UserWorkCollectionViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/25.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import Hero

final class UserWorkCollectionViewCell: UICollectionViewCell {
    typealias Work = GetViewerWorksQuery.Data.Viewer.Work.Edge.Node

    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0.4
        imageView.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        
        imageView.apply(.workImage)
        imageView.hero.isEnabled = true
    }

    func prepare(work: Work) {
        prepare(url: work.image?.url, title: work.title)
    }

    func prepare(url: String?, title: String) {
        imageView.setImage(url: url)
        titleLabel.text = title
    }
    
    func prepareHero(indexPath: IndexPath) {
        imageView.hero.id = "WorkImageView \(indexPath.row)"
        titleLabel.hero.id = "TitleLabel \(indexPath.row)"
    }
}

extension GetViewerWorksQuery.Data.Viewer.Work.Edge.Node.Image {
    var url: String? {
        return twitterAvatarUrl
    }
}
