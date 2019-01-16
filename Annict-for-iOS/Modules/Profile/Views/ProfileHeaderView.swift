//
//  ProfileHeaderView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/01/16.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class ProfileHeaderView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        loadNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.circleFilter()
    }
    
    func prepare(user: GetViewerInfoQuery.Data.Viewer) {
        avatarImageView.setImage(url: user.avatarUrl)
        nameLabel.text = user.name
        usernameLabel.text = "@\(user.username)"
        descriptionLabel.text = user.description
    }
}
