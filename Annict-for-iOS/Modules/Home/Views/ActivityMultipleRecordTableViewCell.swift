//
//  ActivityMultipleRecordTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/03/12.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class ActivityMultipleRecordTableViewCell: UITableViewCell, StoryboardView {
    typealias Reactor = ActivityMultipleRecordTableViewCellReactor

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var workQuoteView: WorkQuoteView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var underArrowButton: UIButton!
    
    var disposeBag = DisposeBag()
    weak var delegate: HomeCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 40 / 2
        workQuoteView.delegate = self
        
        underArrowButton.withImageRenderingMode(.alwaysTemplate)
        underArrowButton.tintColor = UIColor(white: 0.9, alpha: 1)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
        workQuoteView.delegate = self
    }

    func bind(reactor: Reactor) {
        underArrowButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.delegate?.didTapUnderArrow(self, item: .multiRecord(reactor))
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.multipleRecord }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] multipleRecord in
                self?.configure(activityItem: multipleRecord)
            })
            .disposed(by: disposeBag)
    }

    func configure(activityItem: HomeViewReactor.Activity.AsMultipleRecord) {
        let user = activityItem.user.fragments.minimumUser
        avatarImageView.setImage(url: user.avatarUrl)
        nameLabel.text = user.name
        usernameLabel.text = "@" + user.username
        let work = activityItem.work.fragments.minimumWork
        workQuoteView.configure(work: work)
        prepareMessageLabel(activityItem: activityItem)
        if let time = activityItem.createdAt.toDate()?.toRelativeCurrentLocal() {
            timeLabel.text = "・" + time
        }
    }

    private func prepareMessageLabel(activityItem: HomeViewReactor.Activity.AsMultipleRecord) {
        let episodes = activityItem.records?.nodes?.compactMap { $0?.episode.fragments.minimumEpisode }
        guard let minEpisode = episodes?.min(by: { $0.sortNumber < $1.sortNumber })?.numberText else {
            messageLabel.text = "\(activityItem.work.fragments.minimumWork.title)を見ました。"
            return
        }
        guard let maxEpisode = episodes?.max(by: { $0.sortNumber < $1.sortNumber })?.numberText else {
            messageLabel.text = "\(activityItem.work.fragments.minimumWork.title)を見ました。"
            return
        }
        messageLabel.text = "\(minEpisode)から\(maxEpisode)を見ました。"
    }
}


extension ActivityMultipleRecordTableViewCell: QuoteViewDelegate {
    func didSelect() {
        delegate?.didSelect(item: .multiRecord(reactor!))
    }
}
