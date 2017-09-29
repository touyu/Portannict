//
//  AnimeInfoTableViewCell.swift
//  Annict-Today
//
//  Created by Yuto Akiba on 2017/09/23.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

final class AnimeInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var animeIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let url = URL(string: "https://pbs.twimg.com/media/C-RE3BEUAAEndKp.jpg")!
        let data = try! Data(contentsOf: url)
        animeIcon.image = UIImage(data: data)
        
        titleLabel.text = "サクラクエスト 第23話 雪解けのクリスタル"
    }
}
