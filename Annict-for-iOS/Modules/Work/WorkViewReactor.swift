//
//  WorkViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/12/01.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class WorkViewReactor: Reactor {
    enum Action {
        case fetchEpisodes
        case updateStatusState(StatusState)
    }
    
    enum Mutation {
        case setEpisodes([MinimumEpisode])
        case updateStatus(StatusState)
        case setWork(MinimumWork)
    }
    
    struct State {
        var work: MinimumWork
        var episodes: [MinimumEpisode] = []
        
        init(work: MinimumWork) {
            self.work = work
        }
    }
    
    let initialState: State
    let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, work: MinimumWork) {
        initialState = State(work: work)
        self.provider = provider
    }
    
    func reactorForEpisode(index: Int) -> EpisodeRecordsViewReactor {
        return .init(provider: provider, episode: currentState.episodes[index])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchEpisodes:
            return fetchEpisodes().map { .setEpisodes($0) }
        case .updateStatusState(let state):
            let localUpdateStatus = Observable.just(Mutation.updateStatus(state))
            let updateStatusStream = updateStatus(state: state).map { Mutation.setWork($0) }
            return .merge(localUpdateStatus, updateStatusStream)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setEpisodes(let episodes):
            state.episodes = episodes
        case .updateStatus(let statusState):
            state.work.viewerStatusState = statusState
        case .setWork(let work):
            state.work = work
        }
        return state
    }
    
    private func fetchEpisodes() -> Observable<[MinimumEpisode]> {
        let query = SearchWorksByIdQuery(annictId: currentState.work.annictId)
        return AnnictGraphQL.client.rx.fetch(query: query, cachePolicy: .returnCacheDataAndFetch)
            .asObservable()
            .map { $0.searchWorks?.values.first?.episodes?.values.map { $0.fragments.minimumEpisode } }
            .filterNil()
    }

    private func updateStatus(state: StatusState) -> Observable<MinimumWork> {
        return provider.workAPIService.updateStatus(state: state, workId: currentState.work.id)
    }
}

extension SearchWorksByIdQuery.Data.SearchWork: Connection {}
extension SearchWorksByIdQuery.Data.SearchWork.Node.Episode: Connection {}

