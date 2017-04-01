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
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    struct Const {
        static var tableViewContentInsetTop: CGFloat = 8.0
        static var profileViewHeight: CGFloat = 300.0
        static var tabBarHeight: CGFloat = 49
    }
    
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
        
        // 画面サイズによってtabのサイズが揃うようにする
        self.buttonBarView.layoutIfNeeded()
        
        self.navigationItem.title = "profile".localized(withTableName: "AnnictBaseLocalizable")
        containerView.backgroundColor = UIColor(hex: 0xF2F2F2)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        initScrollView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollView.contentSize = self.baseView.bounds.size
        self.containerView.frame.size.height = self.view.bounds.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadPagerTabStripView()
    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let a = AnnictMeWorksViewController.instantiate(withStoryboard: "AnnictMeWorks")
        a.mode = .watching
        a.delegate = self
        let b = AnnictMeWorksViewController.instantiate(withStoryboard: "AnnictMeWorks")
        b.mode = .wannaWatch
        b.delegate = self
        let c = AnnictMeWorksViewController.instantiate(withStoryboard: "AnnictMeWorks")
        c.mode = .watched
        c.delegate = self
        let d = AnnictMeWorksViewController.instantiate(withStoryboard: "AnnictMeWorks")
        d.mode = .onHold
        d.delegate = self
        let e = AnnictMeWorksViewController.instantiate(withStoryboard: "AnnictMeWorks")
        e.mode = .stopWatching
        e.delegate = self
        return [a, b, c, d, e]
    }

    @IBAction func tappedSettingButton(_ sender: Any) {
        let settingNavigationController = SettingNavigationController.instantiate(withStoryboard: .setting)
        self.present(settingNavigationController, animated: true, completion: nil)
    }
    
    fileprivate func initScrollView() {
        scrollView.delegate = self
        scrollView.tag = 1
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        
        if scrollView.tag == 1 {
            
            if scrollView.contentOffset.y > Const.profileViewHeight {
                // 親スクロールをtableViewに伝搬させる
                propagateScrollToTableView(float: scrollView.contentOffset.y - Const.profileViewHeight)
                scrollView.contentOffset.y = Const.profileViewHeight
            }
            
            if scrollView.contentOffset.y < 0 {
                scrollView.contentOffset.y = 0
            }
        }
    }
    
    fileprivate func getCurrentTableView() -> UITableView {
        let annictMeWorksViewController = self.viewControllers[self.currentIndex] as! AnnictMeWorksViewController
        return annictMeWorksViewController.tableView
    }
    
    fileprivate func propagateScrollToTableView(float: CGFloat) {
        let tableView = self.getCurrentTableView()
        let contentOffsetY = tableView.contentOffset.y + float
        if tableView.contentSize.height > tableView.bounds.height + contentOffsetY {
            tableView.contentOffset.y = contentOffsetY
        }
    }
}

extension AnnictMeWorksTabViewController: AnnictMeWorksViewControllerDelegate {
    func didScroll(_ scrollView: UIScrollView) {
        
        let parentScrollView = self.scrollView!
        let childScrollView = scrollView

        
        // tableView上スクロール
        if childScrollView.contentOffset.y > -Const.tableViewContentInsetTop {
            if parentScrollView.contentOffset.y >= 0 && parentScrollView.contentOffset.y < Const.profileViewHeight {
                parentScrollView.contentOffset.y += Const.tableViewContentInsetTop + childScrollView.contentOffset.y
                childScrollView.contentOffset.y = -Const.tableViewContentInsetTop
            }
        } else {
            if parentScrollView.contentOffset.y > 0 && parentScrollView.contentOffset.y <= Const.profileViewHeight {
                parentScrollView.contentOffset.y += Const.tableViewContentInsetTop + childScrollView.contentOffset.y
                childScrollView.contentOffset.y = -Const.tableViewContentInsetTop
            }
        }
    }
}
