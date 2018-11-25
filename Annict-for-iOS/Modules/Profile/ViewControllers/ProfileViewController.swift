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

    @IBOutlet private weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        reactor = Reactor()
        
        super.viewDidLoad()
        
        prepareTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        fetch()
    }

    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .take(1)
            .map { Reactor.Action.fetch }
            .do(onNext: { _ in
                print(reactor)
            })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.viewer }
            .filterNil()
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
//    private func fetch() {
//        guard let client = client else { return }
//        let states: [StatusState] = [.watching, .wannaWatch, .watched, .onHold, .stopWatching]
//        let queries = states.compactMap(GetViewerWorksQuery.init)
//        let requests = queries.compactMap { client.rx.fetch(query: $0).asObservable() }
//        Observable.zip(requests)
//            .subscribe(onNext: { data in
//                for elem in data {
//                    elem.viewer?.works?.value
//                }
//            })
//            .disposed(by: disposeBag)
//
//        client.rx
//            .fetch(query: GetViewerInfoQuery())
//            .subscribe(onSuccess: { data in
//
//            })
//            .disposed(by: disposeBag)
//    }
    
    private func prepareTableView() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UserInfoTableViewCell.self)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(classType: UserInfoTableViewCell.self, for: indexPath)
        guard let viewer = reactor?.currentState.viewer else { return cell }
        cell.prepare(user: viewer)
        return cell
    }
}

extension GetViewerWorksQuery.Data.Viewer.Work {
    var value: [Edge.Node] {
        guard let edges = edges else { return []}
        return edges.compactMap { $0?.node }
    }
}
