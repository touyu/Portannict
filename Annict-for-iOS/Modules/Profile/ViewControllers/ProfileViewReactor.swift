//
//  ProfileViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

typealias Viewer = GetViewerInfoQuery.Data.Viewer

final class ProfileViewReactor: Reactor {
    typealias Work = GetViewerWorksQuery.Data.Viewer.Work.Node
    
    var initialState: State
    
    private var client = AnnictGraphQL.client
    
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }

    enum Action {
        case fetch
    }

    enum Mutation {
        case setViewer(Viewer)
    }

    struct State {
        var viewer: Viewer?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetch:
            return client.rx
                .fetch(query: GetViewerInfoQuery(), cachePolicy: .returnCacheDataAndFetch)
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
            UserDefaultsRepository.save(value: viewer, forKey: .viewer)
        }
        return state
    }
    
    func reactorForChild(statusState: StatusState) -> ProfileWorksViewReactor {
        return .init(provider: provider, statusState: statusState)
    }
}

extension GetViewerWorksQuery.Data.Viewer.Work: Connection { }
