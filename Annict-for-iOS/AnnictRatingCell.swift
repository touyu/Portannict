//
//  AnnictRatingCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit


protocol AnnictRatingCellDelegate {
    func changeRating(rating: Int)
}


class AnnictRatingCell: UITableViewCell {
    
    var delegate: AnnictRatingCellDelegate?
    
    @IBOutlet dynamic fileprivate weak var star1: UIImageView!
    @IBOutlet dynamic fileprivate weak var star2: UIImageView!
    @IBOutlet dynamic fileprivate weak var star3: UIImageView!
    @IBOutlet dynamic fileprivate weak var star4: UIImageView!
    @IBOutlet dynamic fileprivate weak var star5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapedContentView(_:)))
        self.contentView.addGestureRecognizer(tapGesture)
        self.initStars()
    }
    
    fileprivate func initStars() {
        let stars = [star1, star2, star3, star4, star5]
        for (i, star) in stars.enumerated() {
            star?.tag = i + 1
            star?.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapedStar(_:)))
            star?.addGestureRecognizer(tapGesture)
        }
    }
    
    func tapedStar(_ sender: UITapGestureRecognizer) {
        guard let tapedStar = sender.view as? UIImageView else { return }
        let stars = [star1, star2, star3, star4, star5]
        // 初期化
        _ = stars.map { $0?.image = #imageLiteral(resourceName: "inactive_star") }
        _ = stars[0...tapedStar.tag-1].map { $0?.image = #imageLiteral(resourceName: "active_star") }
        self.delegate?.changeRating(rating: tapedStar.tag)
    }
    
    func tapedContentView(_ sender: UITapGestureRecognizer) {
        let stars = [star1, star2, star3, star4, star5]
        // 初期化
        _ = stars.map { $0?.image = #imageLiteral(resourceName: "inactive_star") }
        self.delegate?.changeRating(rating: 0)
    }
}
