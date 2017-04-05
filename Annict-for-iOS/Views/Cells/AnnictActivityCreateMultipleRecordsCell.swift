//
//  AnnictActivityCreateMultipleRecordsCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/04/02.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class AnnictActivityCreateMultipleRecordsCell: UITableViewCell {
    
    var activity: AnnictActivityResponse? {
        didSet {
            guard let activity = self.activity else { return }
            
            initUserInfo(userData: activity.user)
            initTimeLabel(createdAt: activity.createdAt)
            initMessageLabel(title: activity.work?.title, multipleRecords: activity.multipleRecords)
            initAnnictWorkView(work: activity.work)
        }
    }
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var annictWorkView: UIView!
    @IBOutlet weak var animeImageView: UIImageView!
    @IBOutlet weak var animeTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
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
    
    private func initMessageLabel(title: String?, multipleRecords: [AnnictMultipleRecord]?) {
        guard let title = title else {
            messageLabel.text = ""
            return
        }
        
        let (minNumberEpisode, maxNumberEpisode) = getMinMaxNumberEpisodes(multipleRecords: multipleRecords)
        
        guard let minNumberText = minNumberEpisode?.numberText else {
            return
        }
        
        guard let maxNumberText = maxNumberEpisode?.numberText else {
            return
        }
        
        if minNumberText == maxNumberText {
            let text = NSMutableAttributedString(string: "\(title) \(minNumberText)を見ました")
            text.addAttribute(NSForegroundColorAttributeName, value: UIColor.annictBlue, range: NSMakeRange(0, title.characters.count))
            messageLabel.attributedText = text
        } else {
            let text = NSMutableAttributedString(string: "\(title) \(minNumberText)から\(maxNumberText)を見ました")
            text.addAttribute(NSForegroundColorAttributeName, value: UIColor.annictBlue, range: NSMakeRange(0, title.characters.count))
            messageLabel.attributedText = text
        }
    }
    
    private func initAnnictWorkView(work: AnnictWorkResponse?) {
        guard let work = work else { return }
        
        AnnictImageManager.setImage(imageView: animeImageView, imageURL: work.images?.recommendedURL)
        animeTitleLabel.text = work.title
    }
    
    private func getMinMaxNumberEpisodes(multipleRecords: [AnnictMultipleRecord]?) -> (minNumberEpisode: AnnictEpisodeResponse?, maxNumberEpisode: AnnictEpisodeResponse?) {
        guard let multipleRecords = multipleRecords else { return (minNumberEpisode: nil, maxNumberEpisode: nil) }
        
        let sortedMultipleRecords = multipleRecords.sorted(by: { multipleRecord0, multipleRecord1 in
            guard let episode0 = multipleRecord0.episode ,let sortNumber0 = episode0.sortNumber else { return false }
            guard let episode1 = multipleRecord1.episode ,let sortNumber1 = episode1.sortNumber else { return false }
            
            return sortNumber0 < sortNumber1
        })
        
        return (minNumberEpisode: sortedMultipleRecords.first?.episode, maxNumberEpisode: sortedMultipleRecords.last?.episode)
    }
}
