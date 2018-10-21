//
//  RatingStateView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/05/30.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

@IBDesignable
class RatingStateView: UIView {
    
    var state: RatingState?

    @IBOutlet dynamic private weak var ratingStateLabel: UILabel!
    @IBOutlet dynamic private var backView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return backView.frame.size
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func set(ratingState: RatingState) {
        state = ratingState
        ratingStateLabel.text = ratingState.localizedString
        ratingStateLabel.sizeToFit()
        backView.frame.size = getSize(text: ratingState.localizedString)
        backgroundColor = ratingState.color
        invalidateIntrinsicContentSize()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: RatingStateView.self), bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            self.addSubview(view)
        }
        
        layer.cornerRadius = 2
        layer.masksToBounds = true
    }
    
    private func getSize(text: String) -> CGSize {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        return CGSize(width: label.bounds.width+12, height: 18)
    }
}
