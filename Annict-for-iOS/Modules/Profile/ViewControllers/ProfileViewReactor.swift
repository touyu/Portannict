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
    var initialState: State
    
    private var client: ApolloClient? = {
        let configuration = URLSessionConfiguration.default
        guard let token = UserDefaultsRepository.fetch(forKey: .accessToken, type: String.self) else { return nil }
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"]
        let url = URL(string: "https://api.annict.com/graphql")!
        let transport = HTTPNetworkTransport(url: url, configuration: configuration)
        return ApolloClient(networkTransport: transport)
    }()

    init() {
        initialState = State()
    }

    enum Action {
        case fetch
    }

    enum Mutation {
        case setViewer(GetViewerInfoQuery.Data.Viewer)
    }

    struct State {
        var viewer: GetViewerInfoQuery.Data.Viewer?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        guard let client = client else { return .empty() }
        
        switch action {
        case .fetch:
            return client.rx
                .fetch(query: GetViewerInfoQuery())
                .asObservable()
                .debug()
                .map { $0.viewer }
                .filterNil()
                .map { Mutation.setViewer($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setViewer(let viewer):
            state.viewer = viewer
        }
        return state
    }
}
