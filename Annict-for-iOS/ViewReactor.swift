//
//  ViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/22.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class ViewReactor: Reactor {
    let initialState: State
    let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
        self.initialState = State(value: 0)
    }
    
    enum Action {
        case increase
    }
    
    enum Mutation {
        case increaseValue
        case setValue(Int)
    }
    
    struct State {
        var value: Int
    }
    
    func mutate(action: ViewReactor.Action) -> Observable<ViewReactor.Mutation> {
        switch action {
        case .increase:
            return Observable.just(Mutation.increaseValue)
        }
    }
    
    func transform(mutation: Observable<ViewReactor.Mutation>) -> Observable<ViewReactor.Mutation> {
        let counterServiceMutation = provider.counterService.event
            .filter { $0 == .increase10 }
            .map { [weak self] _ in self?.currentState.value ?? 0 }
            .map { Mutation.setValue($0 + 10) }
        return Observable.of(mutation, counterServiceMutation).merge().do(onNext: { value in
            print(value)
        })
    }
    
    func reduce(state: ViewReactor.State, mutation: ViewReactor.Mutation) -> ViewReactor.State {
        var state = state
        switch mutation {
        case .increaseValue:
            state.value += 1
        case .setValue(let value):
            state.value = value
        }
        return state
    }
    
}
