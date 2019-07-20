//
//  HomeViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class HomeViewController: UIViewController, StoryboardView {
    typealias Reactor = HomeViewReactor

    @IBOutlet weak var tableView: UITableView!

    var disposeBag = DisposeBag()

    private let refreshControl = UIRefreshControl()
    
    private var cellHeightList: [IndexPath: CGFloat] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ActivityRecordTableViewCell.self,
                           ActivityStatusTableViewCell.self,
                           ActivityMultipleRecordTableViewCell.self,
                           HomeTitleTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
    }
    
    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .take(1)
            .map { Reactor.Action.fetchActivities }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        tableView.rx.setDataSource(self)
            .disposed(by: disposeBag)

        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        tableView.rx.triggeredPagination()
            .map { Reactor.Action.loadMore }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .map { Reactor.Action.forceFetch }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state.map { $0.activities }
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        guard let reactor = reactor else { return 0 }
        return reactor.currentState.activities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(classType: HomeTitleTableViewCell.self, for: indexPath)
            cell.configure(title: "Home")
            return cell
        }
        
        guard let reactor = reactor else { return .init() }
        let acitivity = reactor.currentState.activities[indexPath.row]
        let heroID = "work_image_view\(indexPath.row)"
        switch acitivity.itemType {
        case .status(let item):
            let cell = tableView.dequeueReusableCell(classType: ActivityStatusTableViewCell.self, for: indexPath)
            cell.configure(activityItem: item, heroID: heroID)
            return cell
        case .record(let item):
            let cell = tableView.dequeueReusableCell(classType: ActivityRecordTableViewCell.self, for: indexPath)
            cell.configure(activityItem: item, heroID: heroID)
            return cell
        case .review(let item):
            return .init()
        case .multipleRecord(let item):
            let cell = tableView.dequeueReusableCell(classType: ActivityMultipleRecordTableViewCell.self, for: indexPath)
            cell.configure(activityItem: item, heroID: heroID)
            return cell
        case .unknown:
            return .init()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 { return }
        
        tableView.deselectRow(at: indexPath, animated: true)
    
        guard let r = reactor?.reactorForWork(index: indexPath.row) else { return }
        WorkViewController.presentPanModal(fromVC: self, reactor: r)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        }
        
        if !cellHeightList.keys.contains(indexPath) {
            cellHeightList[indexPath] = cell.frame.height
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        
        guard let height = self.cellHeightList[indexPath] else {
            return UITableView.automaticDimension
        }
        return height
    }
}
