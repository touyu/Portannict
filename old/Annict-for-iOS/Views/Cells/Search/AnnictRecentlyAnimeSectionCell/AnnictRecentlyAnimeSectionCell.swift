//
//  AnnictRecentlyAnimeSectionCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/15.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class AnnictRecentlyAnimeSectionCell: UITableViewCell {
    
    @IBOutlet dynamic fileprivate weak var titleLabel: UILabel!
    
    func set(title: String) {
        self.titleLabel.text = title
    }
}
