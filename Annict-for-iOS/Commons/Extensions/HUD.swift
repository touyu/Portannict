//
//  HUD.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/12/04.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import PKHUD

extension HUD {
    static func showToFront(_ content: HUDContentType) {
        show(content, onView: UIApplication.shared.windows.last)
    }

    static func flashToFront(_ content: HUDContentType, delay: TimeInterval = 0) {
        flash(content, onView: UIApplication.shared.windows.last, delay: delay)
    }
}
