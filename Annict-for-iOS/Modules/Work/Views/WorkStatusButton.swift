//
//  WorkStatusButton.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/19.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

protocol WorkStatusButtonDelegate: class {
    func didTap(_ workStatusButton: WorkStatusButton)
    func didTapDetail(_ workStatusButton: WorkStatusButton)
}

final class WorkStatusButton: UIView, NibOwnerLoadable {
    var didTap: (() -> Void)?
    var didTapDetail: (() -> Void)?
    
    weak var delegate: WorkStatusButtonDelegate?

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var threeDots: UIImageView!

    private var status: StatusState = .noState

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 48)
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

        roundedRectangleFilter()
        titleLabel.textColor = .white

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(taped))
        addGestureRecognizer(tapGesture)

        threeDots.isUserInteractionEnabled = true
        threeDots.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapedThreeDots)))
    }

    @objc private func taped() {
        Taptic.run(.impact(.medium))
        
        didTap?()
        delegate?.didTap(self)
    }

    @objc private func tapedThreeDots() {
        Taptic.run(.impact(.medium))

        didTapDetail?()
        delegate?.didTapDetail(self)
    }

    func configure(status: StatusState) {
        self.status = status

        switch status {
        case .noState:
            titleLabel.text = StatusState.wannaWatch.localizedText
            backgroundColor = UIColor(white: 0.8, alpha: 1)
        case .wannaWatch, .watched, .watching, .stopWatching, .onHold:
            titleLabel.text = status.localizedText
            backgroundColor = UIColor(hex: 0x3498DB)
        default:
            break
        }
    }
}
