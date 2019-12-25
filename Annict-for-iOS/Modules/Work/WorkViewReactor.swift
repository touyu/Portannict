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
        case loadMore
        case updateStatusState(StatusState)
    }
    
    enum Mutation {
        case setEpisodes([MinimumEpisode])
        case apppendEpisodes([MinimumEpisode])
        case updateStatus(StatusState)
        case setWork(MinimumWork)
        case setPageInfo(PageInfoF)
    }
    
    struct State {
        var work: MinimumWork
//        var episodes: [MinimumEpisode] = []
        var cellReactors: [EpisodeTitleTableViewCellReactor] = []
        var pageInfo: PageInfoF?
        
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
        return .init(provider: provider, episode: currentState.cellReactors[index].currentState.episode)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchEpisodes:
            let fetch = fetchEpisodes().share(replay: 1)
            let setEpisodes = fetch
                .map { $0.values.map { $0.fragments.minimumEpisode } }
                .map { Mutation.setEpisodes($0) }
            let setPageInfo = fetch
                .map { $0.pageInfo.fragments.pageInfoF }
                .map { Mutation.setPageInfo($0) }
            return Observable.merge(setEpisodes, setPageInfo)
        case .loadMore:
            guard let pageInfo = currentState.pageInfo, pageInfo.hasNextPage else { return .empty() }
            let fetch = fetchEpisodes(after: pageInfo.endCursor).share(replay: 1)
            let setEpisodes = fetch
                .map { $0.values.map { $0.fragments.minimumEpisode } }
                .map { Mutation.apppendEpisodes($0) }
            let setPageInfo = fetch
                .map { $0.pageInfo.fragments.pageInfoF }
                .map { Mutation.setPageInfo($0) }
            return Observable.merge(setEpisodes, setPageInfo)
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
            state.cellReactors = episodes.map(EpisodeTitleTableViewCellReactor.init)
        case .apppendEpisodes(let episodes):
            state.cellReactors += episodes.map(EpisodeTitleTableViewCellReactor.init)
        case .updateStatus(let statusState):
            state.work.viewerStatusState = statusState
        case .setWork(let work):
            state.work = work
        case .setPageInfo(let pageInfo):
            state.pageInfo = pageInfo
        }
        return state
    }
    
    private func fetchEpisodes(after: String? = nil) -> Observable<SearchWorksByIdQuery.Data.SearchWork.Node.Episode> {
        let query = SearchWorksByIdQuery(annictId: currentState.work.annictId, after: after)
        var stream = AnnictGraphQL.client.rx.fetch(query: query, cachePolicy: .returnCacheDataAndFetch)
        if after != nil {
            stream = AnnictGraphQL.client.rx.fetchMaybe(query: query, cachePolicy: .returnCacheDataAndFetch).asObservable()
        }
        
        return stream
            .map { $0.searchWorks?.values.first?.episodes }
            .filterNil()
    }

    private func updateStatus(state: StatusState) -> Observable<MinimumWork> {
        return provider.workAPIService.updateStatus(state: state, workId: currentState.work.id)
    }
}

extension SearchWorksByIdQuery.Data.SearchWork: Connection {}
extension SearchWorksByIdQuery.Data.SearchWork.Node.Episode: Connection {}

