//
//  WatchingWorksViewController.swift
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

final class WatchingWorksViewController: UIViewController, StoryboardView {
    typealias Reactor = WatchingWorksViewReactor

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

    }
}

extension WatchingWorksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension WatchingWorksViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let tableView = scrollView as? UITableView {
            delegate?.tableViewDidScroll(tableView)
        }
    }
}

extension WatchingWorksViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "見てる"
    }
}

extension WatchingWorksViewController: TableViewProvider { }
