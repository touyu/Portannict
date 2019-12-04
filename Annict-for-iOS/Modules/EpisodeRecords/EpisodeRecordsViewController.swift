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
    private var postButton: UIButton = {
        let button = UIButton(icon: .pencil)
        button.layer.cornerRadius = 25
        button.tintColor = UIColor(hex: 0xFA5871)
        button.applyFABShadow()
        return button
    }()
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(EpisodeRecordTableViewCell.self,
                           EpisodeRecordTitleTableViewCell.self)
        tableView.tableFooterView = UIView()
        preparePostButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        postButton.updateShodowPath()
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

        postButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                PostRecordViewController.presentPanModal(fromVC: self, reactor: reactor.reactorForPostRecord())
            })
            .disposed(by: disposeBag)
    }

    private func preparePostButton() {
        view.addSubview(postButton)
        postButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.bottom.equalTo(view.snp.bottom).offset(-40)
        }
    }
}

extension EpisodeRecordsViewController {
    static func presentAsStork(fromVC: UIViewController, reactor: Reactor) {
        let vc = EpisodeRecordsViewController.loadStoryboard(reactor: reactor)
        fromVC.presentAsStork(vc, height: nil, showIndicator: false, showCloseButton: false)
    }
}

extension EpisodeRecordsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return reactor!.currentState.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(classType: EpisodeRecordTitleTableViewCell.self, for: indexPath)
            cell.configure(title: "レビュー" + " (\(reactor!.currentState.episode.recordCommentsCount))")
            return cell
        }
        let cell = tableView.dequeueReusableCell(classType: EpisodeRecordTableViewCell.self, for: indexPath)
        cell.configure(record: reactor!.currentState.records[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension EpisodeRecordsViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
}

extension EpisodeRecordsViewController: EpisodeRecordTableViewCellDelegate {
    func didTapUnderArrowButton(_ cell: EpisodeRecordTableViewCell, record: MinimumRecord) {
        let user = record.user.fragments.minimumUser
//        let viewer = UserDefaultsRepository.fetch(forKey: .viewer, type: Viewer.self)
        
//        if user.annictId == viewer?.annictId {
//            showAlertForMe(record)
//            return
//        }
        
        showAlertForOtherUser(cell: cell, user: user)
    }
    
    private func showAlertForOtherUser(cell: EpisodeRecordTableViewCell, user: MinimumUser) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let reportAction = UIAlertAction(title: "投稿を報告する", style: .default, handler: nil)
        let blockAction = UIAlertAction(title: "ユーザーをブロックする", style: .default) { [weak self] _ in
            self?.reactor?.action.onNext(.block(user.annictId))
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alert.addAction(reportAction)
        alert.addAction(blockAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = cell.contentView
        alert.popoverPresentationController?.sourceRect = cell.contentView.frame
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlertForMe(_ record: MinimumRecord) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "投稿を削除する", style: .destructive) { [weak self] _ in
            self?.reactor?.action.onNext(.deleteRecord(record.id))
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
