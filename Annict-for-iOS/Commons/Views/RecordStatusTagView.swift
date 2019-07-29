//
//  RecordStatusTagView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/25.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class RecordStatusTagView: UIView, NibOwnerLoadable {
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: labelSize.width + 16, height: 20)
    }

    @IBOutlet private weak var titleLabel: UILabel!

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

        layer.cornerRadius = 4
        layer.masksToBounds = true

        titleLabel.textColor = .white
    }

    func configure(ratingState: RatingState) {
        backgroundColor = ratingState.color
        titleLabel.text = ratingState.localizedText
        invalidateIntrinsicContentSize()
    }
}
