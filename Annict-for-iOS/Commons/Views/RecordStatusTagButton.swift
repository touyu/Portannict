//
//  RecordStatusTagView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/24.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class RecordStatusTagButton: UIView, NibOwnerLoadable {
    @IBOutlet private weak var titleLabel: UILabel!
    
    var isSelected: Bool = false {
        didSet {
            guard let state = ratingState else { return }
            configure(ratingState: state)
        }
    }
    var ratingState: RatingState?
    
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: labelSize.width + 32, height: 32)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        roundedRectangleFilter()
    }
    
    private func commonInit() {
        loadNib()
        titleLabel.textColor = UIColor(hex: 0x464646)
    }
    
    func configure(ratingState: RatingState) {
        self.ratingState = ratingState
        backgroundColor = isSelected ? ratingState.color : UIColor(hex: 0xEBEBEB)
        titleLabel.textColor = isSelected ? .white : UIColor(hex: 0x464646)
        titleLabel.text = ratingState.localizedText
    }
}

extension RatingState {
    var color: UIColor {
        switch self {
        case .great:
            return UIColor(hex: 0x3498DB)
        case .good:
            return UIColor(hex: 0x2ECC71)
        case .average:
            return UIColor(hex: 0xF39C12)
        case .bad:
            return UIColor(hex: 0x95A5A6)
        default:
            return .white
        }
    }
    
    var localizedText: String {
        switch self {
        case .great:
            return "すごく良い"
        case .good:
            return "良い"
        case .average:
            return "普通"
        case .bad:
            return "良くない"
        default:
            return ""
        }
    }
}
