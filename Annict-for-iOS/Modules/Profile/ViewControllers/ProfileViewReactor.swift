//
//  ProfileViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileViewReactor: Reactor {
    typealias Work = GetViewerWorksQuery.Data.Viewer.Work.Edge.Node
    typealias Viewer = GetViewerInfoQuery.Data.Viewer
    
    var initialState: State
    
    private var client = AnnictGraphQL.client
    
    private let provider: ServiceProviderType

    init() {
        provider = ServiceProvider()
        initialState = State()
    }

    enum Action {
        case fetch
    }

    enum Mutation {
        case setViewer(GetViewerInfoQuery.Data.Viewer)
        case setWorks([[Work]])
    }

    struct State {
        var viewer: Viewer?
        var allWorks: [[Work]] = []
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetch:
            let viewer = client.rx
                .fetch(query: GetViewerInfoQuery(), cachePolicy: .returnCacheDataAndFetch)
                .map { $0.viewer }
                .filterNil()
                .map { Mutation.setViewer($0) }
            
            let works = Observable<[StatusState]>
                .just([.watching, .wannaWatch, .watched, .onHold, .stopWatching])
                .mapMany { GetViewerWorksQuery(state: $0) }
                .flatMapMany { [weak self] query -> Observable<GetViewerWorksQuery.Data> in
                    guard let self = self else { return .empty() }
                    return self.client.rx.fetchMaybe(query: query, cachePolicy: .returnCacheDataAndFetch).asObservable()
                }
                .mapMany { $0.viewer?.works?.value ?? [] }
                .map { Mutation.setWorks($0) }
            
            return .merge(viewer, works)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setViewer(let viewer):
            state.viewer = viewer
            UserDefaultsRepository.save(value: viewer, forKey: .viewer)
        case .setWorks(let allWorks):
            state.allWorks = allWorks
            UserDefaultsRepository.save(value: allWorks, forKey: .viewerAllWorks)
        }
        return state
    }
}

extension GetViewerWorksQuery.Data.Viewer.Work {
    var value: [Edge.Node] {
        guard let edges = edges else { return []}
        return edges.compactMap { $0?.node }
    }
}
