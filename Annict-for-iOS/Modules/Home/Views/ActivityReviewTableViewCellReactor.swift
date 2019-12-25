//
//  ActivityReviewTableViewCellReactor.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/12/25.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import ReactorKit
import RxSwift

final class ActivityReviewTableViewCellReactor: Reactor {
    enum Action {

    }

    enum Mutation {

    }

    struct State {
        var review: Review
    }

    let initialState: State

    init(review: Review) {
        initialState = State(review: review)
    }
}
