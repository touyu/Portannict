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
    typealias Reactor = ProfileViewReactor
    
    var disposeBag = DisposeBag()
    
    @IBOutlet private weak var headerView: ProfileHeaderView!
    @IBOutlet private weak var headerViewTopConstraint: NSLayoutConstraint!
    //    @IBOutlet private weak var buttonBarViewTopConstraint: NSLayoutConstraint!
    
    private var headerViewFittingCompressedHeight: CGFloat {
        return headerView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
    }
    
    private var insetTop: CGFloat {
        return headerViewFittingCompressedHeight + buttonBarView.bounds.height
    }
    
    override func viewDidLoad() {
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        
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
        let vc1 = WatchingWorksViewController.loadStoryboard(reactor: .init())
        let vc2 = WatchingWorksViewController.loadStoryboard(reactor: .init())
        let vc3 = WatchingWorksViewController.loadStoryboard(reactor: .init())
        let vc4 = WatchingWorksViewController.loadStoryboard(reactor: .init())
        let vc5 = WatchingWorksViewController.loadStoryboard(reactor: .init())
        let vcs = [vc1, vc2, vc3, vc4, vc5]
        vcs.forEach { $0.delegate = self }
        return vcs
    }
    
    private func refreshTableViewContentInsetTop() {
        viewControllers
            .compactMap { ($0 as? TableViewProvider)?.tableView }
            .forEach {
                $0.contentInset.top = insetTop
                $0.scrollIndicatorInsets.top = insetTop
            }
    }
}

extension ProfileViewController: ChildPagerTabStripDelegate {
    func tableViewWillDisplay(_ tableView: UITableView) {
        tableView.contentInset.top = insetTop
        tableView.scrollIndicatorInsets.top = insetTop
//        tableView.contentOffset.y = -Const.insetTop

        var aaa = viewControllers
            .compactMap { ($0 as? TableViewProvider)?.tableView }
            .filter { $0 != tableView }
            .map { min($0.contentOffset.y, -40) }
        aaa.append(-insetTop)
        tableView.contentOffset.y = aaa.max() ?? 0
    }
    
    func tableViewDidScroll(_ tableView: UITableView) {
//        print(tableView.contentOffset.y)
//        buttonBarViewTopConstraint.constant = max(-tableView.contentOffset.y - buttonBarView.bounds.height, 0)
        // 0 -> -headerView.Bounds.height
        headerViewTopConstraint.constant = max(-tableView.contentOffset.y - insetTop, -headerViewFittingCompressedHeight)
        print(headerViewTopConstraint.constant)
        
        let tableViews = viewControllers
            .compactMap { ($0 as? TableViewProvider)?.tableView }
            .filter { $0 != tableView }
            
        tableViews
            .forEach { $0.contentOffset.y = tableView.contentOffset.y }
    }
}

extension UITableView {
    func setContentInsetTop(_ insetTop: CGFloat) {
        contentInset.top = insetTop
        scrollIndicatorInsets.top = insetTop
        contentOffset.y = -insetTop
    }
}
