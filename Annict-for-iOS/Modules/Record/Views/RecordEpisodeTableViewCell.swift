//
//  RecordEpisodeTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/28.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit
import RxGesture

final class RecordEpisodeTableViewCell: UITableViewCell, StoryboardView {
    typealias Reactor = RecordEpisodeTableViewCellReactor

    var didTapImage: (() -> Void)?
    var disposeBag = DisposeBag()

    @IBOutlet private weak var workImageView: UIImageView!
    @IBOutlet private weak var workTitleLabel: UILabel!
    @IBOutlet private weak var episodeTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        workImageView.isUserInteractionEnabled = true
        workImageView.apply(.workImage)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
        episodeTitleLabel.text = ""
    }
    
    func bind(reactor: Reactor) {
        workImageView.rx.tapGesture()
            .when(.began, .ended, .cancelled)
            .subscribe(onNext: { [weak self] tapGesture in
                self?.didTapImage?()
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.work }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] work in
                self?.configure(work: work)
            })
            .disposed(by: disposeBag)
    }

    func configure(work: Reactor.Work) {
        let minimumWork = work.fragments.minimumWork
        workImageView.setImage(workID: minimumWork.annictId)
        workTitleLabel.text = minimumWork.title
        if let episode = work.didNotTrackEpisode {
            episodeTitleLabel.text = episode.numberAndTitle
        }
    }
}

extension GetViewerWatchingEpisodesQuery.Data.Viewer.Work.Node {
    var didNotTrackEpisode: MinimumEpisode? {
        guard let episodes = episodes else { return nil }
        let es = episodes.values
            .map { $0.fragments.minimumEpisode }
        guard let maxDidTrack = es.filter({ $0.viewerDidTrack }).max(by: { $0.annictId < $1.annictId }) else {
            return es.first
        }
        return es.filter { $0.annictId > maxDidTrack.annictId }.min(by: { $0.annictId < $1.annictId })
    }
}
