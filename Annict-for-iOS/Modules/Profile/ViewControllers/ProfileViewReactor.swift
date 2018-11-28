//
//  ProfileViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift
import Apollo

final class ProfileViewReactor: Reactor {
    typealias Work = GetViewerWorksQuery.Data.Viewer.Work.Edge.Node
    typealias Viewer = GetViewerInfoQuery.Data.Viewer
    
    var initialState: State
    
    private var client: ApolloClient? = {
        let configuration = URLSessionConfiguration.default
        guard let token = UserDefaultsRepository.fetch(forKey: .accessToken, type: String.self) else { return nil }
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"]
        let url = URL(string: "https://api.annict.com/graphql")!
        let transport = HTTPNetworkTransport(url: url, configuration: configuration)
        return ApolloClient(networkTransport: transport)
    }()
    
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
        case setWatchingWorks([Work])
        case setWannaWatchWorks([Work])
        case setWorks([[Work]])
    }

    struct State {
        var viewer: Viewer? = UserDefaultsRepository.fetch(forKey: .viewer, type: Viewer.self)
        var watchingWorks: [Work] = []
        var wannaWatchWorks: [Work] = []
        var allWorks: [[Work]] = UserDefaultsRepository.fetch(forKey: .viewerAllWorks, type: [[Work]].self) ?? []
//        var allWorks: [[Work]] = []
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        guard let client = client else { return .empty() }
        
        switch action {
        case .fetch:
            let viewer = client.rx
                .fetch(query: GetViewerInfoQuery())
                .asObservable()
                .map { $0.viewer }
                .filterNil()
                .map { Mutation.setViewer($0) }
            
            let works = Observable<[StatusState]>
                .just([.watching, .wannaWatch, .watched, .onHold, .stopWatching])
                .mapMany { GetViewerWorksQuery(state: $0) }
                .flatMapMany { client.rx.fetch(query: $0).asObservable() }
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
        case .setWatchingWorks(let works):
            state.watchingWorks = works
        case .setWannaWatchWorks(let works):
            state.wannaWatchWorks = works
        case .setWorks(let allWorks):
            state.allWorks = allWorks
            UserDefaultsRepository.save(value: allWorks, forKey: .viewerAllWorks)
        }
        return state
    }
}
