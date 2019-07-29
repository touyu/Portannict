//
//  Taptic.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/19.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

enum Taptic {

    case notification(UINotificationFeedbackGenerator.FeedbackType)
    case impact(UIImpactFeedbackGenerator.FeedbackStyle)
    case selection

    static func run(_ type: Taptic) {
        let closure: () -> Void
        switch type {
        case .notification(let notificationType):
            closure = {
                let generator = UINotificationFeedbackGenerator()
                generator.prepare()
                generator.notificationOccurred(notificationType)
            }

        case .impact(let style):
            closure = {
                let generator = UIImpactFeedbackGenerator(style: style)
                generator.prepare()
                generator.impactOccurred()
            }

        case .selection:
            closure = {
                let generator = UISelectionFeedbackGenerator()
                generator.prepare()
                generator.selectionChanged()
            }
        }

        DispatchQueue.main.async {
            closure()
        }
    }
}
