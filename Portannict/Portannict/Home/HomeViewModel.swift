//
//  HomeViewModel.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var activities: [Activity] = []

    init(activities: [Activity] = []) {
        self.activities = activities
    }

    func fetch() {
        print("Fetch")
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            self?.activities = PreviewModel.activities
        }
    }
}
