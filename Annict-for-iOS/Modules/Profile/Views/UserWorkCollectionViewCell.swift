//
//  UserWorkCollectionViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/25.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

final class UserWorkCollectionViewCell: UICollectionViewCell {
    typealias Work = GetViewerWorksQuery.Data.Viewer.Work.Edge.Node

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0.4
        imageView.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
    }

    func prepare(work: Work) {
        imageView.setImage(url: work.image?.url)
        titleLabel.text = work.title
    }
}

extension GetViewerWorksQuery.Data.Viewer.Work.Edge.Node.Image {
    var url: String? {
        return twitterAvatarUrl
    }
}
