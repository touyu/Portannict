//
//  ParentPagerViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/04/01.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import XLPagerTabStrip

protocol ParentPager {
    var headerViewTopConstraint: NSLayoutConstraint! { get }
    func viewControllers(_ parentPager: ParentPager) -> [ChildPagerViewController]
    func headerView(_ parentPager: ParentPager) -> UIView
    func heigthForHeaderView(_ parentPager: ParentPager) -> CGFloat
}

extension ParentPager where Self: PagerTabStripViewController {
    var childScrollViews: [UIScrollView] {
        return viewControllers.compactMap {  ($0 as? ScrollViewProvider)?.provideScrollView() }
    }
}

class ParentPagerViewController: ButtonBarPagerTabStripViewController, ParentPager, ChildPagerTabStripDelegate {
    
    @IBOutlet weak var headerViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView(self).frame.size.height = heigthForHeaderView(self)
    }
    
    var insetTop: CGFloat {
        return heigthForHeaderView(self) + buttonBarView.bounds.height
    }
    
    func headerView(_ parentPager: ParentPager) -> UIView {
        return UIView()
    }
    
    func heigthForHeaderView(_ parentPager: ParentPager) -> CGFloat {
        return headerView(self).systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
    }
    
    func viewControllers(_ parentPager: ParentPager) -> [ChildPagerViewController] {
        return []
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let vcs = viewControllers(self)
        vcs.forEach { $0.delegate = self }
        return vcs
    }
    
    func scrollViewWillDisplay(_ scrollView: UIScrollView) {
        scrollView.contentInset.top = insetTop
        scrollView.scrollIndicatorInsets.top = insetTop
        scrollView.contentInset.bottom = 1000
        //
        var insetTops = childScrollViews
            .filter { $0 != scrollView }
            .map { min($0.contentOffset.y, -buttonBarView.bounds.height) }
        insetTops.append(-insetTop)
        scrollView.contentOffset.y = insetTops.max() ?? 0
    }
    
    func scrollViewDidScrolled(_ scrollView: UIScrollView) {
        headerViewTopConstraint.constant = max(-scrollView.contentOffset.y - insetTop,
                                               -heigthForHeaderView(self))
        
        if scrollView.contentOffset.y <= -scrollView.contentInset.top {
            return
        }
        
        let otherScrollViews = childScrollViews
            .filter { $0 != scrollView }
        
        for otherScrollView in otherScrollViews {
            if scrollView.contentOffset.y >= -buttonBarView.bounds.height {
                return
            }
            otherScrollView.contentOffset.y = scrollView.contentOffset.y
        }
        
    }
}
