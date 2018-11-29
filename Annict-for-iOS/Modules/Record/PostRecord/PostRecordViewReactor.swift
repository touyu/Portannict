//
//  PostRecordViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class PostRecordViewReactor: Reactor {

    var initialState: State
    
    private let client = AnnictGraphQL.client

    init(episode: EpisodeDetails) {
        initialState = State(episode: episode)
    }

    enum Action {
        case record(String?)
    }

    enum Mutation {
        case recordSuccess
    }

    struct State {
        var episode: EpisodeDetails
        var isRecordingSuccess = false
        
        init(episode: EpisodeDetails) {
            self.episode = episode
        }
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .record(let comment):
            let query = CreateRecordMutation(episodeId: currentState.episode.id, comment: comment)
            return client.rx.perform(mutation: query)
                .asObservable()
                .map { _ in .recordSuccess }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .recordSuccess:
            state.isRecordingSuccess = true
        }
        return state
    }
}
