//
//  AnnictActivityCreateStatusCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/04/01.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import DateToolsSwift

class AnnictActivityCreateStatusCell: UITableViewCell {
    
    var activity: AnnictActivityResponse? {
        didSet {
            guard let activity = self.activity else { return }
            
            initUserInfo(userData: activity.user)
            initTimeLabel(createdAt: activity.createdAt)
            initMessageLabel(title: activity.work?.title, status: activity.status)
            initAnnictWorkView(work: activity.work)
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
    
    private func initMessageLabel(title: String?, status: AnimeStatus?) {
        guard let title = title, let status = status else {
            messageLabel.text = ""
            return
        }
        
        let text = NSMutableAttributedString(string: "\(title) のステータスを「\(status.localizedString)」に変更しました")
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.annictBlue, range: NSMakeRange(0, title.characters.count))
        messageLabel.attributedText = text
    }
    
    private func initAnnictWorkView(work: AnnictWorkResponse?) {
        guard let work = work else { return }
        
        setTwitterIcon(imageView: animeImageView, username: work.twitterUserName)
        animeTitleLabel.text = work.title
    }
    
    private func setTwitterIcon(imageView: UIImageView!, username: String?) {
        if let username = username {
            if let url = URL(string: "http://furyu.nazo.cc/twicon/\(username)/original") {
                imageView.kf.setImage(with: url)
            }
        }
    }
}
