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

    }

    enum Mutation {

    }

    struct State {
        var initialTitle: String
        var titleLabelHeroID: String
    }
    
    var initialState: State
    
    init(title: String, titleLabelHeroID: String) {
        initialState = State(initialTitle: title, titleLabelHeroID: titleLabelHeroID)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
