//
//  WorkEpisodeViewViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/04/02.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import XLPagerTabStrip

final class WorkEpisodeViewViewController: ChildPagerViewController, StoryboardView {
    typealias Reactor = WorkEpisodeViewViewReactor

    var disposeBag = DisposeBag()

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        reactor = Reactor(annictId: 6084)
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }

    override func provideScrollView() -> UIScrollView? {
        return tableView
    }
    
    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .map { Reactor.Action.fetchEpisodes }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tableView.rx.setDataSource(self)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.episodes }
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

}

extension WorkEpisodeViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reactor!.currentState.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = reactor!.currentState.episodes[indexPath.row].title
        return cell
    }
}

extension WorkEpisodeViewViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "エピソード")
    }
}
