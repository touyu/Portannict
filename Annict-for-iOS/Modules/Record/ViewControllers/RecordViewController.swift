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
            tableView.register(RecordEpisodeTableViewCell.self,
                               HomeTitleTableViewCell.self)
            tableView.refreshControl = refreshControl
        }
    }
    
    var disposeBag = DisposeBag()
    
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .take(1)
            .map { Reactor.Action.fetch }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tableView.rx.reachedBottom()
            .map { Reactor.Action.loadMore }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        refreshControl.rx
            .controlEvent(.valueChanged)
            .map { Reactor.Action.fetch }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.cellReactors }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] works in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .filter { !$0 }
            .subscribe(onNext: { [weak self] _ in
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
}

extension RecordViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return reactor?.currentState.cellReactors.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(classType: HomeTitleTableViewCell.self, for: indexPath)
            cell.configure(title: "Record")
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(classType: RecordEpisodeTableViewCell.self, for: indexPath)
        cell.reactor = reactor!.currentState.cellReactors[indexPath.row]
        cell.didTapImage = { [weak self] in
            guard let self = self else { return }
            WorkViewController.presentPanModal(fromVC: self, reactor: self.reactor!.reactorForWork(index: indexPath.item))
        }
        return cell
    }
}

extension RecordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let r = reactor!.reactorForPostRecord(index: indexPath.row) else { return }
        PostRecordViewController.presentPanModal(fromVC: self, reactor: r)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        
        return 100
    }
}
