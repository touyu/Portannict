//
//  EpisodeRecordsViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/25.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import SPStorkController

final class EpisodeRecordsViewController: UIViewController, StoryboardView {
    typealias Reactor = EpisodeRecordsViewReactor

    @IBOutlet private weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(EpisodeRecordTableViewCell.self)
        tableView.tableFooterView = UIView()
    }

    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .take(1)
            .map { Reactor.Action.fetchRecords }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tableView.rx.setDataSource(self)
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.records }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension EpisodeRecordsViewController {
    static func presentAsStork(fromVC: UIViewController, reactor: Reactor) {
        let vc = EpisodeRecordsViewController.loadStoryboard(reactor: reactor)
        fromVC.presentAsStork(vc, height: nil, showIndicator: false, showCloseButton: false)
    }
}

extension EpisodeRecordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reactor!.currentState.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(classType: EpisodeRecordTableViewCell.self, for: indexPath)
        cell.configure(record: reactor!.currentState.records[indexPath.row])
        return cell
    }
}

extension EpisodeRecordsViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
}
