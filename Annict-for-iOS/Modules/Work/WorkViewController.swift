//
//  WorkViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/12/01.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import PanModal
import SnapKit


final class WorkViewController: UIViewController, StoryboardView {
    typealias Reactor = WorkViewReactor
    
    var disposeBag = DisposeBag()

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(WorkHeaderTableViewCell.self,
                           EpisodeTitleTableViewCell.self)
    }
    
    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .take(1)
            .map { Reactor.Action.fetchEpisodes }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.episodes }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] episodes in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension WorkViewController {
    static func presentPanModal(fromVC: UIViewController, reactor: Reactor) {
        let vc = WorkViewController.loadStoryboard(reactor: reactor)
        fromVC.presentPanModal(vc)
    }
}

extension WorkViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
           return 1
        }
        return reactor!.currentState.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(classType: WorkHeaderTableViewCell.self, for: indexPath)
            cell.configure(work: reactor!.currentState.work)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(classType: EpisodeTitleTableViewCell.self, for: indexPath)
            cell.configure(episode: reactor!.currentState.episodes[indexPath.row])
            return cell
        }
    }
}

extension WorkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 460
        } else {
            return 50
        }
    }
}

extension WorkViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return tableView
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }
    
    var showDragIndicator: Bool {
        return false
    }
}
