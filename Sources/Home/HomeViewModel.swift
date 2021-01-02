//
//  HomeViewModel.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/24.
//

import Foundation
import Combine
import Fluxer

final class HomeViewModel: ViewModel {
//    @Published var activities: [Activity] = []
//
//    init(activities: [Activity] = []) {
//        self.activities = activities
//    }

    enum Action {
//        case fetch
    }

    enum Mutation {

    }

    class State: ObservableObject {
        
    }

    @Published var state: State = State()

    init() {
        initilize()
    }

    func mutate(action: Action) -> AnyPublisher<Mutation, Never> {
        return Empty().eraseToAnyPublisher()
    }

    func reduce(mutation: Mutation) {

    }

    func fetch() {
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
//            self?.activities = PreviewModel.activities
//        }
    }
}
