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
    private enum _Const {
        static let normalTextColor = UIColor(hex: 0x8E8E8E)
        static let selectedBackgroundColor = UIColor(hex: 0xEFEFEF)
        static let selectedTextColor = UIColor(hex: 0x333333)
    }
    
    @IBOutlet weak var headerViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        headerView(self).frame.size.height = heigthForHeaderView(self)

    }

    // safeAreaのtopInsetを考慮するかどうか
    var isEnableTopSafeAreaInset: Bool = false
    
    var insetTop: CGFloat {
        return heigthForHeaderView(self) + buttonBarView.bounds.height
    }
    
    private var buttonMarkView: ButtonMarkView? {
        return buttonBarView as? ButtonMarkView
    }
    
    func headerView(_ parentPager: ParentPager) -> UIView {
        return UIView()
    }
    
    func heigthForHeaderView(_ parentPager: ParentPager) -> CGFloat {
        return headerView(self).systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
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
        // viewのinsetを取得しようとするとviewDidLoadだと取得できないので決めうちにする必要がある

        let safeAreaInsetTop: CGFloat = 44

        if isEnableTopSafeAreaInset {
            scrollView.contentInset.top = insetTop - safeAreaInsetTop
            scrollView.scrollIndicatorInsets.top = insetTop - safeAreaInsetTop
        } else {
            scrollView.contentInset.top = insetTop
            scrollView.scrollIndicatorInsets.top = insetTop
        }
        scrollView.contentInset.bottom = 1000
        //
        var insetTops = childScrollViews
            .filter { $0 != scrollView }
            .map { min($0.contentOffset.y, -buttonBarView.bounds.height) }
        insetTops.append(-insetTop)
//        if isEnableTopSafeAreaInset {
//            insetTops = insetTops.map { $0 + safeAreaInsetTop }
//        }
        scrollView.contentOffset.y = insetTops.max() ?? 0
    }
    
    func scrollViewDidScrolled(_ scrollView: UIScrollView) {
        let safeAreaInsetTop: CGFloat = 44

        var constant = -insetTop - scrollView.contentOffset.y
        var minTopConstant = -heigthForHeaderView(self)
        if isEnableTopSafeAreaInset {
            constant += safeAreaInsetTop
            minTopConstant += safeAreaInsetTop
        }
        
        headerViewTopConstraint.constant = max(constant, minTopConstant)

        // TODO: safeArea考慮
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
    
    func prepareButtonBar() {
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.buttonBarItemTitleColor = _Const.normalTextColor
        settings.style.buttonBarLeftContentInset = 24
        settings.style.buttonBarRightContentInset = 24
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            newCell?.label.textColor = _Const.selectedTextColor
            oldCell?.label.textColor = _Const.normalTextColor
        }
        
        buttonMarkView?.selectedMarkView.backgroundColor = _Const.selectedBackgroundColor
    }
}
