//
//  MultiEpisodeRecordFloatingView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/12/25.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class MultiEpisodeRecordFloatingView: UIView {
    private let backgroundBlurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    private let buttonBlurView: UIVisualEffectView = {
        let v = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        v.layer.cornerRadius = 12
        v.layer.masksToBounds = true
        return v
    }()

    private let label: UILabel = {
        let l = UILabel()
        l.text = "第一話〜第十二話"
        l.sizeToFit()
        l.font = .boldSystemFont(ofSize: 14)
        l.textColor = UIColor(hex: 0x3F3F41)
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .clear

        addSubview(backgroundBlurView)
        backgroundBlurView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }

        addSubview(label)
        label.snp.makeConstraints {
            $0.left.equalTo(snp.left).offset(18)
            $0.centerY.equalTo(snp.centerY)
        }

        addSubview(buttonBlurView)
        buttonBlurView.snp.makeConstraints {
            $0.width.equalTo(75)
            $0.height.equalTo(24)
            $0.right.equalTo(snp.right).offset(-16)
            $0.centerY.equalTo(snp.centerY)
        }
    }

}
