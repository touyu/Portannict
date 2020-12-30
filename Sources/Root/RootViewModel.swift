//
//  RootViewModel.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/20.
//

import Combine
import SwiftUI
import Fluxer

final class RootViewModel: ViewModel {
//    @Environment(\.envValues) var envValues

    enum Action {

    }

    enum Mutation {

    }

    class State: ObservableObject {

    }

    @Published var state = State()

    init() {
        initilize()
    }
}
