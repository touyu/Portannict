//
//  AnnictMeWorkCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/12.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit


// MARK: - AnnictMeWorkCell

class AnnictMeWorkCell: UITableViewCell {
    
    @IBOutlet dynamic fileprivate weak var baseView: UIView!
    @IBOutlet dynamic fileprivate weak var titleLabel: UILabel!
    @IBOutlet dynamic fileprivate weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initBaseView()
    }
    
    func set(work: AnnictWorkResponse) {
        self.titleLabel.text = work.title
    }
    
    fileprivate func initBaseView() {
        self.baseView.layer.masksToBounds = true
        self.baseView.layer.cornerRadius = 4
    }
}
