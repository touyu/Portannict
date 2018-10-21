//
//  ActivitiesNavigationController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/04/01.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class ActivitiesNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
}
