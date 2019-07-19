//
//  RootTabBarReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/03/12.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class RootTabBarReactor: Reactor {
    enum Action {

    }

    enum Mutation {

    }

    struct State {

    }

    let initialState: State
    let provider: ServiceProviderType

    var reactorForHome: HomeViewReactor {
        return .init(provider: provider)
    }
    
    var reactorForProfile: ProfileViewReactor {
        return .init(provider: provider)
    }

    init(provider: ServiceProviderType) {
        initialState = State()
        self.provider = provider
    }
}
