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

final class ProfileViewController: UIViewController, StoryboardView {
    typealias Reactor = ProfileViewReactor
    
    enum Section: Int, CaseIterable {
        case userInfo
        case works
    }

    @IBOutlet private weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        reactor = Reactor()
        
        super.viewDidLoad()
        
        prepareTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .take(1)
            .map { Reactor.Action.fetch }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.viewer }
            .filterNil()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.allWorks }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func prepareTableView() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UserInfoTableViewCell.self,
                           UserWorksWithSectionTitleCell.self)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let reactor = reactor else { return 0 }
        switch Section(rawValue: section)! {
        case .userInfo:
            return 1
        case .works:
            return reactor.currentState.allWorks
                .map { $0.isEmpty ? 0 : 1 }
                .reduce(0) { $0 + $1 }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section)! {
        case .userInfo:
            let cell = tableView.dequeueReusableCell(classType: UserInfoTableViewCell.self, for: indexPath)
            guard let viewer = reactor?.currentState.viewer else { return cell }
            cell.prepare(user: viewer)
            return cell
        case .works:
            let cell = tableView.dequeueReusableCell(classType: UserWorksWithSectionTitleCell.self, for: indexPath)
            guard let allWorks = reactor?.currentState.allWorks.filter({ !$0.isEmpty }) else { return cell }
            cell.prepare(title: StatusState.values[indexPath.item].localizedText, works: allWorks[indexPath.item])
            return cell
        }
    }
}

extension GetViewerWorksQuery.Data.Viewer.Work {
    var value: [Edge.Node] {
        guard let edges = edges else { return []}
        return edges.compactMap { $0?.node }
    }
}
