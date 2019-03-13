//
//  WorkQuoteView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/03/12.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class WorkQuoteView: UIView, NibOwnerLoadable {
    @IBOutlet private(set) weak var workImageView: UIImageView!
    @IBOutlet private weak var workTitleLabel: UILabel!

    override var intrinsicContentSize: CGSize {
        return CGSize(width: CGFloat.greatestFiniteMagnitude, height: 60)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        loadNib()

        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.borderColor = UIColor(hex: 0xE2E2E2).cgColor
        layer.borderWidth = 0.5
        
        workImageView.layer.cornerRadius = 8
        workImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }

    func configure(work: MinimumWork) {
        workImageView.setImage(url: work.image?.url)
        workTitleLabel.text = work.title
    }
}
