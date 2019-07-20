//
//  RecordEpisodeTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/28.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

final class RecordEpisodeTableViewCell: UITableViewCell {
    typealias Work = GetViewerWatchingEpisodesQuery.Data.Viewer.Work.Edge.Node

    @IBOutlet private weak var workImageView: UIImageView!
    @IBOutlet private weak var workTitleLabel: UILabel!
    @IBOutlet private weak var episodeTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        workImageView.apply(.workImage)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        episodeTitleLabel.text = ""
    }

    func prepare(work: Work) {
        workImageView.setImage(workID: work.annictId)
        workTitleLabel.text = work.title
        if let episode = work.didNotTrackEpisode {
            episodeTitleLabel.text = episode.numberAndTitle
        }
    }
}

extension GetViewerWatchingEpisodesQuery.Data.Viewer.Work.Edge.Node {
    var didNotTrackEpisode: EpisodeDetails? {
        return episodes?.elements
            .map { $0.fragments.episodeDetails }
            .filter { !$0.viewerDidTrack }
            .min(by: { $0.annictId < $1.annictId })
    }
}

extension EpisodeDetails {
    var numberAndTitle: String {
        var result = ""
        if let numberText = numberText {
            result = "\(numberText) "
        }
        
        if let title = title {
            result += title
        }
        
        return result
    }
}
