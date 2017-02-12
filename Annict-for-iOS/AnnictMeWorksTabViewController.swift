//
//  AnnictMeWorksTabViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/12.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import XLPagerTabStrip


// MARK: - AnnictMeWorksTabViewController

class AnnictMeWorksTabViewController: ButtonBarPagerTabStripViewController {
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
        
        self.navigationItem.title = "Annict"
        containerView.backgroundColor = UIColor(hex: 0xF2F2F2)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let a = AnnictMeWorksViewController.instantiate(withStoryboard: "AnnictMeWorks")
        a.mode = .watching
        let b = AnnictMeWorksViewController.instantiate(withStoryboard: "AnnictMeWorks")
        b.mode = .wannaWatch
        let c = AnnictMeWorksViewController.instantiate(withStoryboard: "AnnictMeWorks")
        c.mode = .watched
        let d = AnnictMeWorksViewController.instantiate(withStoryboard: "AnnictMeWorks")
        d.mode = .onHold
        let e = AnnictMeWorksViewController.instantiate(withStoryboard: "AnnictMeWorks")
        e.mode = .stopWatching
        return [a, b, c, d, e]
    }
}
