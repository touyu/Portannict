//
//  RootViewModel.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/11/12.
//

import Foundation
import Combine
import SwiftUI
import Fluxer

final class TestViewModel: ViewModel {
    enum Action {
        case increment
    }

    enum Mutation {
        case increment
    }

    class State: ObservableObject {
        @Published var number = 0
    }

    @Published var state = State()

    init() {
        initilize()
    }

    func mutate(action: Action) -> AnyPublisher<Mutation, Never> {
        switch action {
        case .increment:
            return TestAPIClient.send()
                .map { _ in Mutation.increment }
                .catch { _ in Just(Mutation.increment) }
                .eraseToAnyPublisher()
        }
    }

    func reduce(mutation: Mutation) {
        switch mutation {
        case .increment:
            state.number += 1
        }
    }

    func transform(mutation: AnyPublisher<Mutation, Never>) -> AnyPublisher<Mutation, Never> {
        let m = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .map { _ in Mutation.increment }

        return mutation.merge(with: m).eraseToAnyPublisher()
    }
}

final class TestAPIClient {
    static func send() -> Future<Int, Error> {
        return Future { promise in
            promise(.success(1))
        }
    }
}
