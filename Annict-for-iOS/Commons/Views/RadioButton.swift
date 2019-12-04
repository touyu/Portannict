//
//  RadioButton.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/12/04.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class RadioButton: UIView {
    var color: UIColor = UIColor(hex: 0x3498DB) {
        didSet {
            updateColor()
        }
    }

    var isOn: Bool = false {
        didSet {
            checkView.isHidden = !isOn
        }
    }

    let checkView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        layer.borderWidth = 1.5
        checkView.isHidden = !isOn
        addSubview(checkView)
        checkView.snp.makeConstraints {
            $0.edges.equalTo(snp.edges).inset(4)
        }
        updateColor()

        let gesture = UITapGestureRecognizer { [weak self] sender in
            self?.isOn.toggle()
            Taptic.run(.impact(.medium))
        }
        addGestureRecognizer(gesture)
    }

    func updateColor() {
        layer.borderColor = color.cgColor
        checkView.backgroundColor = color
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        checkView.layer.cornerRadius = checkView.bounds.width / 2
        checkView.layer.masksToBounds = true
        layer.cornerRadius = bounds.width / 2
        layer.masksToBounds = true
    }
}
