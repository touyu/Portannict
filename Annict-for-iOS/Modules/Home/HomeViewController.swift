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

    private var cellHeightList: [IndexPath: CGFloat] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ActivityRecordTableViewCell.self,
                           ActivityStatusTableViewCell.self,
                           ActivityMultipleRecordTableViewCell.self)
        tableView.tableFooterView = UIView()
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.mono.black]
//        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.mono.black]
//        navigationController?.navigationBar.transparent()
//        navigationController?.navigationBar.isTranslucent = false
//        extendedLayoutIncludesOpaqueBars = true
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

        tableView.rx.triggeredPagination
            .map { Reactor.Action.loadMore }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state.map { $0.activities }
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let reactor = reactor else { return 0 }
        return reactor.currentState.activities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        tableView.deselectRow(at: indexPath, animated: true)
    
        guard let work = reactor!.currentState.activities[indexPath.item].work else { return }
        WorkViewController.present(fromVC: self, reactor: .init(work: work, heroID: "work_image_view\(indexPath.row)"))
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !cellHeightList.keys.contains(indexPath) {
            cellHeightList[indexPath] = cell.frame.height
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = self.cellHeightList[indexPath] else {
            return UITableView.automaticDimension
        }
        return height
    }
}
