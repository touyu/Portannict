//
//  EpisodeTitleTableViewCellReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/12/25.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class EpisodeTitleTableViewCellReactor: Reactor {
    enum Action {
        case updateIsSelected(Bool)
    }

    enum Mutation {
        case setIsSelected(Bool)
    }

    struct State {
        let episode: MinimumEpisode
        var isSelected: Bool = false
    }

    let initialState: State

    init(episode: MinimumEpisode) {
        initialState = State(episode: episode)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateIsSelected(let isSelected):
            return .just(.setIsSelected(isSelected))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setIsSelected(let isSelected):
            state.isSelected = isSelected
        }
        return state
    }
}

extension EpisodeTitleTableViewCellReactor: Equatable {
    static func == (lhs: EpisodeTitleTableViewCellReactor, rhs: EpisodeTitleTableViewCellReactor) -> Bool {
        return lhs.currentState.episode.resultMap == rhs.currentState.episode.resultMap
            && lhs.currentState.isSelected == rhs.currentState.isSelected
    }
}
