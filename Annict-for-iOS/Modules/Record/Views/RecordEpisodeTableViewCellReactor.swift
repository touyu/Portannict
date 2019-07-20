//
//  RecordEpisodeTableViewCellReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/21.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class RecordEpisodeTableViewCellReactor: Reactor {
    typealias Work = GetViewerWatchingEpisodesQuery.Data.Viewer.Work.Node
    
    enum Action {

    }

    enum Mutation {

    }

    struct State {
        let work: Work
    }
    
    let initialState: State
    
    init(work: Work) {
        initialState = State(work: work)
    }

}

extension RecordEpisodeTableViewCellReactor: Equatable {
    static func == (lhs: RecordEpisodeTableViewCellReactor, rhs: RecordEpisodeTableViewCellReactor) -> Bool {
        return lhs.currentState.work.resultMap == rhs.currentState.work.resultMap
    }
}
