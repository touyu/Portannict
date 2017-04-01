//
//  AnnictActivityCreateRecordCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/04/01.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class AnnictActivityCreateRecordCell: UITableViewCell {
    
    var activity: AnnictActivityResponse? {
        didSet {
            guard let activity = self.activity else { return }
            
            initUserInfo(userData: activity.user)
            initTimeLabel(createdAt: activity.createdAt)
            initMessageLabel(message: activity.record?.comment)
            initAnnictWorkView(work: activity.work, episode: activity.episode)
            initStars(rating: activity.record?.rating)
        }
    }
    
    @IBOutlet dynamic fileprivate weak var avatarImageView: UIImageView!
    @IBOutlet dynamic fileprivate weak var nameLabel: UILabel!
    @IBOutlet dynamic fileprivate weak var usernameLabel: UILabel!
    @IBOutlet dynamic fileprivate weak var timeLabel: UILabel!
    @IBOutlet dynamic fileprivate weak var messageLabel: UILabel!
    
    @IBOutlet dynamic fileprivate weak var annictWorkView: UIView!
    @IBOutlet dynamic fileprivate weak var animeImageView: UIImageView!
    @IBOutlet dynamic fileprivate weak var animeTitleLabel: UILabel!
    @IBOutlet dynamic fileprivate weak var episodeTitleLabel: UILabel!
    
    @IBOutlet dynamic fileprivate weak var star1: UIImageView!
    @IBOutlet dynamic fileprivate weak var star2: UIImageView!
    @IBOutlet dynamic fileprivate weak var star3: UIImageView!
    @IBOutlet dynamic fileprivate weak var star4: UIImageView!
    @IBOutlet dynamic fileprivate weak var star5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initUI()
    }
    
    func set(activity: AnnictActivityResponse) {
        self.activity = activity
    }
    
    private func initUI() {
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 4
        
        annictWorkView.layer.masksToBounds = true
        annictWorkView.layer.cornerRadius = 4
        annictWorkView.layer.borderWidth = 0.6
        annictWorkView.layer.borderColor = UITableView().separatorColor?.cgColor
    }
    
    private func initUserInfo(userData: AnnictUserResponse?) {
        guard let userData = userData else { return }
        
        if let urlString = userData.avatarURL, let url = URL(string: urlString) {
            self.avatarImageView.kf.setImage(with: url)
        }
        
        self.nameLabel.text = userData.name
        
        if let username = userData.username {
            self.usernameLabel.text = "@" + username
        }
    }
    
    private func initTimeLabel(createdAt: String?) {
        guard let createdAt = createdAt else { return }
        let date = Date(dateString: createdAt, format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        timeLabel.text = date.timeAgoSinceNow
    }
    
    private func initMessageLabel(message: String?) {
        messageLabel.text = message
    }
    
    private func initAnnictWorkView(work: AnnictWorkResponse?, episode: AnnictEpisodeResponse?) {
        guard let work = work else { return }
        
        setTwitterIcon(imageView: animeImageView, username: work.twitterUserName)
        animeTitleLabel.text = work.title
        
        if let numberText = episode?.numberText {
            episodeTitleLabel.text = "\(numberText) "
        }
        
        if let episodeTitle = episode?.title {
            episodeTitleLabel.text = (episodeTitleLabel.text ?? "") + episodeTitle
        }
    }
    
    private func setTwitterIcon(imageView: UIImageView!, username: String?) {
        if let username = username {
            if let url = URL(string: "http://furyu.nazo.cc/twicon/\(username)/original") {
                imageView.kf.setImage(with: url)
            }
        }
    }
    
    private func initStars(rating: Int?) {
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
}
