//
//  TermSettingViewReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/26.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class TermSettingViewReactor: Reactor {
    enum Action {
        case selected(Int, Int)
    }

    enum Mutation {
        case setSelectedSeason(Int, Season.Name)
    }

    struct State {
        let years: [Int] = Array(1980...2020).reversed()
        let seasons: [Season.Name] = [.spring, .summer, .autumn, .winter]

        var selectedSeason = Season.current
    }

    let initialState: State

    init() {
        initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .selected(let yearIndex, let seasonIndex):

            return .just(.setSelectedSeason(currentState.years[yearIndex],
                                            currentState.seasons[seasonIndex]))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setSelectedSeason(let year, let name):
            state.selectedSeason = Season(name: name, year: year)
        }
        return state
    }
}
