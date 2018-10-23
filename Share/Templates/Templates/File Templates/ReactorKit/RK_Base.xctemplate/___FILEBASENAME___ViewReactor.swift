//___FILEHEADER___

import ReactorKit
import RxSwift

final class ___FILEBASENAMEASIDENTIFIER___: Reactor {
    var initialState: State

    init() {
        initialState = State()
    }

    enum Action {

    }

    enum Mutation {

    }

    struct State {

    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
