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

final class ProfileViewController: ButtonBarPagerTabStripViewController, StoryboardView {
    enum Const {
        static let normalColor = UIColor(hex: 0x595959)
        static let selectedColor = UIColor(hex: 0xFF7187)
    }
    
    typealias Reactor = ProfileViewReactor
    
    var disposeBag = DisposeBag()
    
    @IBOutlet private weak var headerView: ProfileHeaderView!
    @IBOutlet private weak var headerViewTopConstraint: NSLayoutConstraint!
    
    private var headerViewFittingCompressedHeight: CGFloat {
        return headerView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
    }
    
    private var insetTop: CGFloat {
        return headerViewFittingCompressedHeight + buttonBarView.bounds.height
    }
    
    override func viewDidLoad() {
        settings.style.selectedBarHeight = 2.0
        settings.style.selectedBarBackgroundColor = Const.selectedColor
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.buttonBarItemTitleColor = Const.normalColor
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = Const.normalColor
            newCell?.label.textColor = Const.selectedColor
        }
        
        reactor = Reactor()
        
        super.viewDidLoad()
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
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let vc1 = ProfileWorksViewController.loadStoryboard(reactor: .init(statusState: .watching))
        let vc2 = ProfileWorksViewController.loadStoryboard(reactor: .init(statusState: .wannaWatch))
        let vc3 = ProfileWorksViewController.loadStoryboard(reactor: .init(statusState: .watched))
        let vc4 = ProfileWorksViewController.loadStoryboard(reactor: .init(statusState: .onHold))
        let vc5 = ProfileWorksViewController.loadStoryboard(reactor: .init(statusState: .stopWatching))
        let vcs = [vc1, vc2, vc3, vc4, vc5]
        vcs.forEach { $0.delegate = self }
        return vcs
    }
    
    private func refreshTableViewContentInsetTop() {
        viewControllers
            .compactMap { ($0 as? CollectionViewProvider)?.collectionView }
            .forEach {
                $0.contentInset.top = insetTop
                $0.scrollIndicatorInsets.top = insetTop
                $0.contentOffset.y = -insetTop
            }
    }
}

extension ProfileViewController: ChildPagerTabStripDelegate {
    func collectionViewWillDisplay(_ collectionView: UICollectionView) {
        collectionView.contentInset.top = insetTop
        collectionView.scrollIndicatorInsets.top = insetTop
        
        var insetTops = viewControllers
            .compactMap { ($0 as? CollectionViewProvider)?.collectionView }
            .filter { $0 != collectionView }
            .map { min($0.contentOffset.y, -40) }
        insetTops.append(-insetTop)
        collectionView.contentOffset.y = insetTops.max() ?? 0
    }
    
    func collectionViewDidScroll(_ collectionView: UICollectionView) {
        headerViewTopConstraint.constant = max(-collectionView.contentOffset.y - insetTop, -headerViewFittingCompressedHeight)
        print(headerViewTopConstraint.constant)
        
        let tableViews = viewControllers
            .compactMap { ($0 as? CollectionViewProvider)?.collectionView }
            .filter { $0 != collectionView }
        
        tableViews
            .forEach { $0.contentOffset.y = collectionView.contentOffset.y }
    }
}
