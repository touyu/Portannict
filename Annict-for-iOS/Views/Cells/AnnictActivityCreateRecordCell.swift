//
//  AnnictActivityCreateRecordCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/04/01.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit
import SwiftyAttributedString

class AnnictActivityCreateRecordCell: UITableViewCell {
    
    var activity: AnnictActivityResponse? {
        didSet {
            guard let activity = self.activity else { return }
            
            initUserInfo(userData: activity.user)
            initTimeLabel(createdAt: activity.createdAt)
            initMessageLabel(message: activity.record?.comment)
            initAnnictWorkView(work: activity.work, episode: activity.episode)
            initStars(rating: activity.record?.rating)
            initInfoTextView(title: activity.work?.title, numberText: activity.episode?.numberText)
        }
    }
    
    @IBOutlet dynamic fileprivate weak var avatarImageView: UIImageView!
    @IBOutlet dynamic fileprivate weak var nameLabel: UILabel!
    @IBOutlet dynamic fileprivate weak var usernameLabel: UILabel!
    @IBOutlet dynamic fileprivate weak var timeLabel: UILabel!
    @IBOutlet dynamic fileprivate weak var messageLabel: UILabel!
    @IBOutlet dynamic fileprivate weak var infoTextView: UITextView!
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        infoTextView.text = ""
        animeTitleLabel.text = ""
        episodeTitleLabel.text = ""
        animeImageView.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        animeImageView.backgroundColor = UIColor(hex: 0xC8C8C8)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        animeImageView.backgroundColor = UIColor(hex: 0xC8C8C8)
    }
    
    func set(activity: AnnictActivityResponse) {
        self.activity = activity
    }
    
    private func initUI() {
        infoTextView.text = ""
        animeTitleLabel.text = ""
        episodeTitleLabel.text = ""
        
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 4
        
        annictWorkView.layer.masksToBounds = true
        annictWorkView.layer.cornerRadius = 4
        annictWorkView.layer.borderWidth = 0.6
        annictWorkView.layer.borderColor = UITableView().separatorColor?.cgColor
        
        infoTextView.textContainerInset = UIEdgeInsets.zero
        infoTextView.textContainer.lineFragmentPadding = 0
    }
    
    private func initUserInfo(userData: AnnictUserResponse?) {
        guard let userData = userData else { return }
        
        AnnictImageManager.setAvatarImage(imageView: avatarImageView, user: userData)
        
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
        AnnictImageManager.setWorkImage(imageView: animeImageView, work: work)
        animeTitleLabel.text = work?.title
        
        if let numberText = episode?.numberText {
            episodeTitleLabel.text = "\(numberText) "
        }
        
        if let episodeTitle = episode?.title {
            episodeTitleLabel.text = (episodeTitleLabel.text ?? "") + episodeTitle
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
    
    private func initInfoTextView(title: String?, numberText: String?) {
        guard let title = title else { return }
        guard let numberText = numberText else {
            let text = "\(title) を見ました"
            let attributedString = text.add(attributes: [Attribute(value: .foregroundColor(.annictBlue), range: .portion(of: .string(title))),
                                                         Attribute(value: .font(.systemFont(ofSize: 14)))])
            infoTextView.attributedText = attributedString
            return
        }
        let text = "\(title) \(numberText) を見ました"
        let attributedString = text.add(attributes: [Attribute(value: .foregroundColor(.annictBlue), range: .portion(of: .string(title))),
                                                     Attribute(value: .foregroundColor(.annictBlue), range: .portion(of: .string(numberText))),
                                                     Attribute(value: .font(.systemFont(ofSize: 14)))])
        infoTextView.attributedText = attributedString
        infoTextView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tappedinfoTextView)))
    }
    
    @objc private func tappedinfoTextView(tap: UITapGestureRecognizer) {
        let location = tap.location(in: infoTextView)
        guard let textPosition = infoTextView.closestPosition(to: location) else { return }
        
        // テキストの先頭とタップした文字の距離をNSIntegerで取得
        let selectedPosition = infoTextView.offset(from: infoTextView.beginningOfDocument, to: textPosition)
        let range = infoTextView.text.findRange(activity?.work?.title)
        
        // タップした文字がリンク文字のrangeに含まれるか判定
        if NSLocationInRange(selectedPosition, range) {
            
            print("taped")
        }
    }
}
