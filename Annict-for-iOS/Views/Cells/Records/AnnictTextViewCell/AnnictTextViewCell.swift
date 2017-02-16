//
//  AnnictTextViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

protocol AnnictTextViewCellDelegate {
    func annictTextViewShouldBeginEditing(_ textView: UITextView)
    func annictTextViewDidChange(_ textView: UITextView)
}

class AnnictTextViewCell: UITableViewCell {
    
    var delegate: AnnictTextViewCellDelegate?
    
    @IBOutlet dynamic fileprivate weak var textView: UITextView!
    
    fileprivate var placeholderLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textView.delegate = self
    }
    
    override func layoutSubviews() {
        if placeholderLabel == nil {
            self.initPlaceHolderLabel()
        }
    }
    
    fileprivate func initPlaceHolderLabel() {
        let label = UILabel()
        label.text = "感想（オプション）"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        self.placeholderLabel = label
        self.textView.addSubview(placeholderLabel!)
    }
}

extension AnnictTextViewCell: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.placeholderLabel?.removeFromSuperview()
        self.delegate?.annictTextViewShouldBeginEditing(textView)
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.annictTextViewDidChange(textView)
    }
}
