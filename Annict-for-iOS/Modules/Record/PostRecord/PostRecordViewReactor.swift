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
    enum Action {
        case record(String?, RatingState?)
        case setShouldShareTwitter(Bool)
    }

    enum Mutation {
        case recordSuccess
        case setShouldShareTwitter(Bool)
    }

    struct State {
        var episode: MinimumEpisode
        var isRecordingSuccess = false
        var shouldShareTwitter = false
        
        init(episode: MinimumEpisode) {
            self.episode = episode
        }
    }
    
    let initialState: State
    let provider: ServiceProviderType
    private let client = AnnictGraphQL.client
    
    init(provider: ServiceProviderType, episode: MinimumEpisode) {
        self.provider = provider
        initialState = State(episode: episode)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .record(let comment, let ratingState):
            return provider.episodeAPIService.createRecord(episodeID: currentState.episode.id, comment: comment, ratingState: ratingState, shareTwitter: currentState.shouldShareTwitter)
                .map { _ in .recordSuccess }
        case .setShouldShareTwitter(let shouldShareTwitter):
            return .just(.setShouldShareTwitter(shouldShareTwitter))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .recordSuccess:
            state.isRecordingSuccess = true
        case .setShouldShareTwitter(let shouldShareTwitter):
            state.shouldShareTwitter = shouldShareTwitter
        }
        return state
    }
}
