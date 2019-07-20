//
//  SearchResultWorkCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/30.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

final class SearchResultWorkCell: UITableViewCell {

    @IBOutlet private weak var workImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = ""
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        workImageView.apply(.workImage)
    }

    func configure(work: MinimumWork) {
        workImageView.setImage(workID: work.annictId)
        titleLabel.text = work.title
    }
}
