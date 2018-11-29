//
//  RecordViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import Apollo

final class RecordViewController: UIViewController, StoryboardView {
    typealias Reactor = RecordViewReactor

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableFooterView = UIView()
            tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
            tableView.register(RecordEpisodeTableViewCell.self)
            tableView.refreshControl = refreshControl
        }
    }
    
    var disposeBag = DisposeBag()
    
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reactor = RecordViewReactor()
    }

    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .take(1)
            .map { Reactor.Action.fetch }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tableView.rx.reachedBottom
            .map { Reactor.Action.loadMore }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        refreshControl.rx
            .controlEvent(.valueChanged)
            .map { Reactor.Action.fetch }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.works }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] works in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.works }
            .delay(0.4, scheduler: MainScheduler.instance)
//            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] works in
                guard self?.refreshControl.isRefreshing == true else { return }
                self?.refreshControl.endRefreshing()
                self?.navigationController?.navigationBar.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
    }
}

extension RecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let reactor = reactor else { return 0 }
        return reactor.currentState.works.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reactor = reactor else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(classType: RecordEpisodeTableViewCell.self, for: indexPath)
        cell.prepare(work: reactor.currentState.works[indexPath.row])
        return cell
    }
}

extension RecordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let episode = reactor?.currentState.works[indexPath.item].didNotTrackEpisode else { return }
        PostRecordViewController.present(fromVC: self, episode: episode)
    }
}
