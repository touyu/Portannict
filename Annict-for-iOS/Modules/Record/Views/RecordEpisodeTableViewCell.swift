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

final class RecordEpisodeTableViewCell: UITableViewCell, StoryboardView {
    typealias Reactor = RecordEpisodeTableViewCellReactor
    
    var disposeBag = DisposeBag()

    @IBOutlet private weak var workImageView: UIImageView!
    @IBOutlet private weak var workTitleLabel: UILabel!
    @IBOutlet private weak var episodeTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        workImageView.apply(.workImage)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
        episodeTitleLabel.text = ""
    }
    
    func bind(reactor: Reactor) {
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
        return episodes?.values
            .map { $0.fragments.minimumEpisode }
            .filter { !$0.viewerDidTrack }
            .min(by: { $0.annictId < $1.annictId })
    }
}
