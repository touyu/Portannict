//
//  AnnictMeWorkCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/12.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit
import Kingfisher


// MARK: - AnnictMeWorkCell

class AnnictMeWorkCell: UITableViewCell {
    
    @IBOutlet dynamic fileprivate weak var baseView: UIView!
    @IBOutlet dynamic fileprivate weak var titleLabel: UILabel!
    @IBOutlet dynamic fileprivate weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initBaseView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.iconImageView.image = nil
    }
    
    func set(work: AnnictWorkResponse) {
        self.titleLabel.text = work.title
        self.setTwitterIcon(imageView: iconImageView, username: work.twitterUserName)
    }
    
    fileprivate func setTwitterIcon(imageView: UIImageView!, username: String?) {
        if let username = username {
            let url = URL(string: "http://furyu.nazo.cc/twicon/\(username)/original")!
//            print("loading...\(url.absoluteString)")
            imageView.kf.setImage(with: url)
        }
    }
    
    fileprivate func initBaseView() {
        self.baseView.layer.masksToBounds = true
        self.baseView.layer.cornerRadius = 4
    }
}
