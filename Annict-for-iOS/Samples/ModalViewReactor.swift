//
//  ModalViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/22.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class ModalViewReactor: Reactor {
    var initialState: ModalViewReactor.State
    let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
        self.initialState = State(value: 0)
    }
    
    enum Action {
        case increase
    }
    
    enum Mutation {
        case setValue(Int)
    }
    
    struct State {
        var value: Int
    }
    
    func mutate(action: ModalViewReactor.Action) -> Observable<ModalViewReactor.Mutation> {
        switch action {
        case .increase:
            return provider.counterService
                .increase10(num: currentState.value)
                .map { Mutation.setValue($0) }
            
        }
    }
    
    func reduce(state: ModalViewReactor.State, mutation: ModalViewReactor.Mutation) -> ModalViewReactor.State {
        var state = state
        switch mutation {
        case .setValue(let value):
            state.value = value
        }
        return state
    }
}
