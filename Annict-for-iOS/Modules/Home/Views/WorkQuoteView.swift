//
//  WorkQuoteView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/03/12.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class WorkQuoteView: UIView, NibOwnerLoadable {
    weak var delegate: QuoteViewDelegate?

    @IBOutlet private(set) weak var workImageView: UIImageView!
    @IBOutlet private weak var workTitleLabel: UILabel!

    private var overlay: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        v.alpha = 0
        return v
    }()

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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        overlay.alpha = 1
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        overlay.alpha = 0
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        overlay.alpha = 0
        delegate?.didSelect()
    }

    private func commonInit() {
        loadNib()

        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.borderColor = UIColor(hex: 0xE2E2E2).cgColor
        layer.borderWidth = 0.5
        
        workImageView.layer.cornerRadius = 8
        workImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]

        addSubview(overlay)
        overlay.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }

    func configure(work: MinimumWork) {
        workImageView.setImage(workID: work.annictId)
        workTitleLabel.text = work.title
    }
}
