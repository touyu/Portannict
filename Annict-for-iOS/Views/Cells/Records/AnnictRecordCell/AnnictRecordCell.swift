//
//  AnnictRecordCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class AnnictRecordCell: UITableViewCell {
    
    var record: AnnictRecordResponse? {
        get {
            return self.setedRecord
        }
    }
    
    @IBOutlet dynamic fileprivate weak var usernameLabel: UILabel!
    @IBOutlet dynamic fileprivate weak var timeLabel: UILabel!
    @IBOutlet dynamic fileprivate weak var commentLabel: UILabel!
    @IBOutlet dynamic fileprivate weak var star1: UIImageView!
    @IBOutlet dynamic fileprivate weak var star2: UIImageView!
    @IBOutlet dynamic fileprivate weak var star3: UIImageView!
    @IBOutlet dynamic fileprivate weak var star4: UIImageView!
    @IBOutlet dynamic fileprivate weak var star5: UIImageView!
    
    fileprivate var setedRecord: AnnictRecordResponse?
    
    func set(record: AnnictRecordResponse) {
        self.setedRecord = record
        self.usernameLabel.text = record.user?.name
        self.commentLabel.text = record.comment
        self.initTimeLabel(createdAt: record.createdAt)
        self.initStars(rating: record.rating)
    }
    
    fileprivate func initStars(rating: Int?) {
        let stars = [star1, star2, star3, star4, star5]
        if let rating = rating {
            _ = stars.map { $0?.alpha = 1; $0?.image = #imageLiteral(resourceName: "inactive_star") }
            for i in 0...rating-1 {
                stars[i]?.image = #imageLiteral(resourceName: "active_star")
            }
        } else {
            _ = stars.map { $0?.alpha = 0 }
        }
    }
    
    private func initTimeLabel(createdAt: String?) {
        guard let createdAt = createdAt else { return }
        let date = Date(dateString: createdAt, format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        timeLabel.text = date.timeAgoSinceNow
    }
}
