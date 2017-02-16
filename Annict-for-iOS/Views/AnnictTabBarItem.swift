//
//  AnnictTabBarItem.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/14.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class AnnictTabBarItem: UITabBarItem {
    override var imageInsets: UIEdgeInsets {
        get { return UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0) }
        set { super.imageInsets = imageInsets }
    }
}
