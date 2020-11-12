//
//  ViewModel.swift
//  Fluxer
//
//  Created by Yuto Akiba on 2020/11/13.
//

import Foundation
import Combine
import SwiftUI

public protocol ViewModel: ObservableObject {
    associatedtype Action
    associatedtype Mutation
    associatedtype State: ObservableObject

    var action: PassthroughSubject<Action, Never> { get }
    var state: State { get set }

    var cancellables: Set<AnyCancellable> { get set }

    func mutate(action: Action) -> AnyPublisher<Mutation, Never>
    func reduce(mutation: Mutation)

    func transform(action: AnyPublisher<Action, Never>) -> AnyPublisher<Action, Never>
    func transform(mutation: AnyPublisher<Mutation, Never>) -> AnyPublisher<Mutation, Never>
//    func transform(state: AnyPublisher<State, Never>) -> AnyPublisher<State, Never>

    func initilize()
}

fileprivate enum ViewModelAssociatedKey {
    static var action: UInt8 = 0
    static var cancellables: UInt8 = 0
}

public extension ViewModel {
    var action: PassthroughSubject<Action, Never> {
        get { return objc_getAssociatedObject(self, &ViewModelAssociatedKey.action) as! PassthroughSubject<Action, Never> }
        set { objc_setAssociatedObject(self, &ViewModelAssociatedKey.action, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }

    var cancellables: Set<AnyCancellable> {
        get { return objc_getAssociatedObject(self, &ViewModelAssociatedKey.cancellables) as! Set<AnyCancellable> }
        set { objc_setAssociatedObject(self, &ViewModelAssociatedKey.cancellables, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }

    func mutate(action: Action) -> AnyPublisher<Mutation, Never> {
        Empty().eraseToAnyPublisher()
    }

    func reduce(mutation: Mutation) {

    }

    func transform(action: AnyPublisher<Action, Never>) -> AnyPublisher<Action, Never> {
        action
    }

    func transform(mutation: AnyPublisher<Mutation, Never>) -> AnyPublisher<Mutation, Never> {
        mutation
    }
}

public extension ViewModel where Self.ObjectWillChangePublisher == ObservableObjectPublisher  {
    func initilize() {

        self.action = PassthroughSubject<Action, Never>()
        self.cancellables = Set<AnyCancellable>()

        // Create binding stream
        let action = self.action
            .eraseToAnyPublisher()

        let transformedAction = transform(action: action)

        let mutation = transformedAction.flatMap { [weak self] action in
            return self?.mutate(action: action) ?? Empty().eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()

        let transformedMutation = transform(mutation: mutation)

        transformedMutation.sink { completion in

        } receiveValue: { [weak self] mutation in
            self?.reduce(mutation: mutation)
        }
        .store(in: &cancellables)

        // State changed event -> ViewModel changed event
        state.objectWillChange.sink(receiveValue: { [weak self] _ in
            self?.objectWillChange.send()
        })
        .store(in: &cancellables)
    }
}
