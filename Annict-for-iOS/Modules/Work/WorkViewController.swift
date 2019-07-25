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
import SPStorkController

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

        reactor.state.map { $0.work }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] episodes in
                self?.tableView.reloadData()
            })
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
        fromVC.presentAsStork(vc, height: nil, showIndicator: false, showCloseButton: false)
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
            let work = reactor!.currentState.work
            cell.configure(work: work)
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(classType: EpisodeTitleTableViewCell.self, for: indexPath)
            cell.configure(episode: reactor!.currentState.episodes[indexPath.row])
            return cell
        }
    }
}

extension WorkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        EpisodeRecordsViewController.presentAsStork(fromVC: self, reactor: reactor!.reactorForEpisode(index: indexPath.item))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 460
        } else {
            return 50
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
}

extension WorkViewController: WorkStatusButtonDelegate {
    func didTap(_ workStatusButton: WorkStatusButton) {
        let work = reactor!.currentState.work
        let currentState = work.viewerStatusState ?? .noState
        
        switch currentState {
        case .noState:
            updateStatusState(.wannaWatch)
        case .wannaWatch, .watched, .watching, .onHold, .stopWatching:
            showAlert(currentState: currentState)
        default:
            break
        }
    }
    
    func didTapDetail(_ workStatusButton: WorkStatusButton) {
        let work = reactor!.currentState.work
        showAlert(currentState: work.viewerStatusState ?? .noState)
    }
    
    private func showAlert(currentState: StatusState) {
        let ac = UIAlertController(title: "ステータスを変更", message: nil, preferredStyle: .actionSheet)
        
        let stateList: [StatusState] = [.noState, .wannaWatch, .watching, .watched, .onHold, .stopWatching].filter { $0 != currentState }
        let actions = stateList.map { [weak self] statusState in
            UIAlertAction(title: statusState.localizedText, style: .default, handler: { [weak self] _ in
                self?.updateStatusState(statusState)
            })
        }
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        actions.forEach {
            ac.addAction($0)
        }
        ac.addAction(cancel)
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? WorkHeaderTableViewCell
        ac.popoverPresentationController?.sourceView = cell
        ac.popoverPresentationController?.sourceRect = cell?.statusButton.frame ?? .zero
        present(ac, animated: true, completion: nil)
    }
    
    private func updateStatusState(_ statusState: StatusState) {
        reactor?.action.onNext(.updateStatusState(statusState))
    }
}
