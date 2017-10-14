//
//  TimelineShimmeringCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/10/12.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class TimelineShimmeringCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.subviews.forEach {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 2
        }
    }
}
