//
//  ProfileWorksViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/01/16.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import XLPagerTabStrip

protocol TableViewProvider {
    var tableView: UITableView! { get set }
}

protocol ChildPagerTabStripDelegate: class {
    func tableViewWillDisplay(_ tableView: UITableView)
    func tableViewDidScroll(_ tableView: UITableView)
}

final class ProfileWorksViewController: UIViewController, StoryboardView {
    typealias Reactor = ProfileWorksViewReactor

    var disposeBag = DisposeBag()
    
    weak var delegate: ChildPagerTabStripDelegate?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        delegate?.tableViewWillDisplay(tableView)
    }

    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .take(1)
            .map { Reactor.Action.fetch }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.works }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension ProfileWorksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension ProfileWorksViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let tableView = scrollView as? UITableView {
            delegate?.tableViewDidScroll(tableView)
        }
    }
}

extension ProfileWorksViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: reactor?.statusState.localizedText)
    }
}

extension ProfileWorksViewController: TableViewProvider { }
