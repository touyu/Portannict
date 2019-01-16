//
//  WatchingWorksViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/01/16.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileWorksViewReactor: Reactor {
    typealias Work = GetViewerWorksQuery.Data.Viewer.Work.Node
    
    enum Action {
        case fetch
    }

    enum Mutation {
        case setWorks([Work])
    }

    struct State {
        var works: [Work] = []
    }
    
    var initialState: State
    var statusState: StatusState
    
    init(statusState: StatusState) {
        initialState = State()
        self.statusState = statusState
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetch:
            let query = GetViewerWorksQuery(state: statusState)
            return AnnictGraphQL.client.rx.fetch(query: query)
                .map { $0.viewer?.works?.values ?? [] }
                .map { .setWorks($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setWorks(let works):
            state.works = works
        }
        return state
    }
}
