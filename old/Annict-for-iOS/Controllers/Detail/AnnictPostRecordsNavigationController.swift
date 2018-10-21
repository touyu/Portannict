//
//  AnnictPostRecordsNavigationController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class AnnictPostRecordsNavigationController: UINavigationController {
    
    // 外部から指定
    var episodeID: Int!
    var dissmissAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let annictPostRecordsVC = self.viewControllers.first as? AnnictPostRecordsViewController {
            annictPostRecordsVC.episodeID = episodeID
            annictPostRecordsVC.dismissAction = dissmissAction
        }
    }
}
