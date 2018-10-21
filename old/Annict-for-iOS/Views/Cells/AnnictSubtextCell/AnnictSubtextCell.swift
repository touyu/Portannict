//
//  AnnictSubtextCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/12.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class AnnictSubtextCell: UITableViewCell {
    
    @IBOutlet dynamic fileprivate weak var titleLabel: UILabel!
    @IBOutlet dynamic fileprivate weak var subtextLabel: UILabel!
    
    var subtextColor: UIColor = .annictPink {
        didSet {
            self.subtextLabel.textColor = subtextColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(information: (title: String, subtext: String)) {
        self.titleLabel.text = information.title
        self.subtextLabel.text = information.subtext
    }
}
