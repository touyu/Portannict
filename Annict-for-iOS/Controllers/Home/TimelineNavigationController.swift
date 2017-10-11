//
//  TimelineNavigationController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/10/11.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class TimelineNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
}
