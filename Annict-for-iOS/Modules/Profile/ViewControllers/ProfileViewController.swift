//
//  ProfileViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import Apollo
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

final class ProfileViewController: ParentPagerViewController, StoryboardView {
    enum Const {
        static let normalTextColor = UIColor(hex: 0x8E8E8E)
        static let selectedBackgroundColor = UIColor(hex: 0xEFEFEF)
        static let selectedTextColor = UIColor(hex: 0x333333)
    }
    
    typealias Reactor = ProfileViewReactor
    
    var disposeBag = DisposeBag()
    
    @IBOutlet private weak var headerView: ProfileHeaderView!
    
    private var buttonMarkView: ButtonMarkView? {
        return buttonBarView as? ButtonMarkView
    }
    
//    private var headerViewFittingCompressedHeight: CGFloat {
//        return headerView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
//    }
//
//    private var insetTop: CGFloat {
//        return headerViewFittingCompressedHeight + buttonBarView.bounds.height
//    }
    
    override func viewDidLoad() {
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.buttonBarItemTitleColor = Const.normalTextColor
        settings.style.buttonBarLeftContentInset = 24
        settings.style.buttonBarRightContentInset = 24
        settings.style.buttonBarItemsShouldFillAvailableWidth = true

        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            newCell?.label.textColor = Const.selectedTextColor
            oldCell?.label.textColor = Const.normalTextColor
        }
        
        reactor = Reactor()
        
        buttonMarkView?.selectedMarkView.backgroundColor = Const.selectedBackgroundColor
        
        super.viewDidLoad()

        let statusBarBackgroundView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarBackgroundView.backgroundColor = .white
        view.addSubview(statusBarBackgroundView)
    }
    
    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .map { Reactor.Action.fetch }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.viewer }
            .filterNil()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] viewer in
                self?.headerView.prepare(user: viewer)
                self?.refreshTableViewContentInsetTop()
            })
            .disposed(by: disposeBag)
    }
    
    override func viewControllers(_ parentPager: ParentPager) -> [ChildPagerViewController] {
        let vc1 = ProfileWorksViewController.loadStoryboard(reactor: .init(statusState: .watching))
        let vc2 = ProfileWorksViewController.loadStoryboard(reactor: .init(statusState: .wannaWatch))
        let vc3 = ProfileWorksViewController.loadStoryboard(reactor: .init(statusState: .watched))
        let vc4 = ProfileWorksViewController.loadStoryboard(reactor: .init(statusState: .onHold))
        let vc5 = ProfileWorksViewController.loadStoryboard(reactor: .init(statusState: .stopWatching))
        let vcs = [vc1, vc2, vc3, vc4, vc5]
        return vcs
    }
    
    override func headerView(_ parentPager: ParentPager) -> UIView {
        return headerView
    }
    
    private func refreshTableViewContentInsetTop() {
        viewControllers
            .compactMap { ($0 as? ScrollViewProvider)?.provideScrollView() }
            .forEach {
                $0.contentInset.top = insetTop
                $0.scrollIndicatorInsets.top = insetTop
                $0.contentOffset.y = -insetTop
            }
    }
}

//extension ProfileViewController: ChildPagerTabStripDelegate {
//    func scrollViewWillDisplay(_ scrollView: UIScrollView) {
//        print(insetTop)
//        scrollView.contentInset.top = insetTop
//        scrollView.scrollIndicatorInsets.top = insetTop
//        scrollView.contentInset.bottom = 1000
//        //
//        var insetTops = childScrollViews
//            .filter { $0 != scrollView }
//            .map { min($0.contentOffset.y, -buttonBarView.bounds.height) }
//        insetTops.append(-insetTop)
//        scrollView.contentOffset.y = insetTops.max() ?? 0
//    }
//
//    func scrollViewDidScrolled(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.y)
//
//        headerViewTopConstraint.constant = max(-scrollView.contentOffset.y - insetTop,
//                                               -headerViewFittingCompressedHeight)
//
//        if scrollView.contentOffset.y <= -scrollView.contentInset.top {
//            return
//        }
//
//        let otherScrollViews = childScrollViews
//            .filter { $0 != scrollView }
//
//        for otherScrollView in otherScrollViews {
//            if scrollView.contentOffset.y >= -buttonBarView.bounds.height {
//                return
//            }
//            otherScrollView.contentOffset.y = scrollView.contentOffset.y
//        }
//    }
//}

extension UIColor {
    public convenience init(from fColor: UIColor, to tColor: UIColor, with per: CGFloat) {
        var fR: CGFloat = 0, fG: CGFloat = 0, fB: CGFloat = 0, fA: CGFloat = 0
        var tR: CGFloat = 0, tG: CGFloat = 0, tB: CGFloat = 0, tA: CGFloat = 0
        
        fColor.getRed(&fR, green: &fG, blue: &fB, alpha: &fA)
        tColor.getRed(&tR, green: &tG, blue: &tB, alpha: &tA)
        
        let r: CGFloat = (tR - fR) * per + fR
        let g: CGFloat = (tG - fG) * per + fG
        let b: CGFloat = (tB - fB) * per + fB
        let a: CGFloat = (tA - fA) * per + fA
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
