//
//  ActivityStatusTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/03/12.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class ActivityStatusTableViewCell: UITableViewCell, StoryboardView {
    typealias Reactor = ActivityStatusTableViewCellReactor

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var workQuoteView: WorkQuoteView!

    var disposeBag = DisposeBag()
    weak var delegate: HomeQuoteViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 40 / 2
        workQuoteView.delegate = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
        workQuoteView.delegate = self
    }

    func bind(reactor: Reactor) {
        reactor.state.map { $0.status }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] status in
                self?.configure(activityItem: status)
            })
            .disposed(by: disposeBag)
    }

    func configure(activityItem: HomeViewReactor.Activity.AsStatus) {
        let user = activityItem.user.fragments.minimumUser
        avatarImageView.setImage(url: user.avatarUrl)
        nameLabel.text = user.name
        usernameLabel.text = "@" + user.username
        let work = activityItem.work.fragments.minimumWork
        workQuoteView.configure(work: work)
        messageLabel.text = "ステータスを「\(activityItem.state.localizedText)」に変更しました。"
        timeLabel.text = activityItem.createdAt.toDate()?.toRelative()

    }
}

extension ActivityStatusTableViewCell: QuoteViewDelegate {
    func didSelect() {
        delegate?.didSelect(item: .status(reactor!))
    }
}
