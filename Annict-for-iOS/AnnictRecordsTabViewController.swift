//
//  AnnictRecordsTabViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import XLPagerTabStrip

class AnnictRecordsTabViewController: ButtonBarPagerTabStripViewController {
    
    // 外部から指定
    var episodeID: Int!
    
    override func viewDidLoad() {
        // set up style before super view did load is executed
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemFont = .systemFont(ofSize: 16, weight: UIFontWeightThin)
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.selectedBarBackgroundColor = UIColor.annictPink
        settings.style.selectedBarHeight = 2.0
        //-
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = UIColor(hex: 0x1E1E1E, alpha: 0.6)
            newCell?.label.textColor = UIColor.annictPink
            
            if animated {
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
            }
            else {
                newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
        
        super.viewDidLoad()
        
        // self.navigationItem.title = work.title
    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let a = AnnictRecordsViewController.instantiate(withStoryboard: "AnnictWorks")
        a.episodeID = episodeID
        a.mode = .all
        let b = AnnictRecordsViewController.instantiate(withStoryboard: "AnnictWorks")
        b.episodeID = episodeID
        b.mode = .comment
        return [a, b]
    }
}