//
//  TimelineCellForStatus.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/10/14.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import Kingfisher

class TimelineCellForStatus: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedAvatarImageView(_:)))
            avatarImageView.addGestureRecognizer(tapGesture)
            avatarImageView.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var workView: UIView! {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedWorkView(_:)))
            workView.addGestureRecognizer(tapGesture)
//            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(tappedWorkView))
//            longPressGesture.minimumPressDuration = 0.01
//            longPressGesture.allowableMovement = 0
//            workView.addGestureRecognizer(longPressGesture)
        }
    }
    @IBOutlet weak var workImageView: UIImageView! {
        didSet {
            workImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var workTitleLabel: UILabel!
    
    private var _activity: FollowingActivity.AsStatus? {
        didSet {
            guard let activity = _activity else { return }
            
            avatarImageView.set(url: activity.user.avatarUrl)
            nameLabel.text = activity.user.name
            usernameLabel.text = "@\(activity.user.username)"
            timeLabel.text = activity.createdAt.toDate().timeAgoSinceNow
            initMessageLabel()
            workImageView.set(url: activity.work.image?.recommendedImageUrl)
            workTitleLabel.text = activity.work.title
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        workView.backgroundColor = .white
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        workView.backgroundColor = .white
    }
    
    func set(activity: FollowingActivity.AsStatus?) {
        _activity = activity
    }
    
    @objc func tappedWorkView(_ sender: UITapGestureRecognizer) {
        print(sender.state.rawValue)
        switch sender.state {
        case .began:
            workView.backgroundColor = UIColor.white.brighten(by: 0.9)
        case .changed:
//            UIView.animate(withDuration: 0.2, animations: { [weak self] in
//                self?.workView.backgroundColor = UIColor.white
//            })
            break
        case .ended:
            UIView.animate(withDuration: 0.4, animations: { [weak self] in
                self?.workView.backgroundColor = UIColor.white
            })
        default:
            break
        }
    }
    
    @objc func tappedAvatarImageView(_ sender: UITapGestureRecognizer) {
        print(sender.state.rawValue)
    }
    
    private func initMessageLabel() {
        guard let activity = _activity else { return }
        let workTitle = activity.work.title
        let state = activity.state.localized()
        messageLabel.text = "\(workTitle)のステータスを「\(state)」に変更しました。"
    }
}
