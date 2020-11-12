//
//  Button.swift
//  Fluxer
//
//  Created by Yuto Akiba on 2020/11/13.
//

import SwiftUI

public extension SwiftUI.Button {
    init<VM>(viewModel: VM, action: VM.Action, @ViewBuilder label: @escaping () -> Label) where VM: ViewModel {
        self.init(action: {
            viewModel.action.send(action)
        }, label: label)
    }
}
