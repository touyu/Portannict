//
//  SeasonWorkCollectionViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/01/18.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class SeasonWorkCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var workImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var statusLabel: BlurBackgroundLabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        workImageView.apply(.workImage)
        statusLabel.layer.cornerRadius = 4
        statusLabel.layer.masksToBounds = true
    }

    func configure(work: MinimumWork) {
        workImageView.setImage(workID: work.annictId)
        titleLabel.text = work.title

        if let state = work.viewerStatusState {
            switch state {
            case .wannaWatch, .watching, .watched, .onHold, .stopWatching:
                statusLabel.isHidden = false
                statusLabel.text = state.localizedText
            default:
                statusLabel.isHidden = true
            }
        }

    }

    func setColumnCount(_ count: Int) {
        if count == 2 {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        }

        if count == 3 {
            titleLabel.font = UIFont.systemFont(ofSize: 11)
        }
    }
}

final class BlurBackgroundLabel: UIView {
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
    private let label = UILabel()

    var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
            layoutIfNeeded()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        blurView.alpha = 0.8
        addSubview(blurView)
        blurView.snp.makeConstraints {
            $0.edges.equalTo(snp.edges)
        }

        addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalTo(snp.top).inset(4)
            $0.bottom.equalTo(snp.bottom).inset(4)
            $0.left.equalTo(snp.left).inset(8)
            $0.right.equalTo(snp.right).inset(8)
        }

        backgroundColor = .clear

        layer.cornerRadius = 4
        layer.masksToBounds = true

        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 12)
    }
}
