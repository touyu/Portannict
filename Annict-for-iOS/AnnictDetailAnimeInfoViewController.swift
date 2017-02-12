//
//  AnnictDetailAnimeInfoViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/12.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import XLPagerTabStrip


// MARK: - AnnictDetailAnimeInfoViewController

class AnnictDetailAnimeInfoViewController: UIViewController {
    
}

extension AnnictDetailAnimeInfoViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "基本情報")
    }
}
