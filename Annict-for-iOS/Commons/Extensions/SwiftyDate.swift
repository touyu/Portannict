//
//  SwiftyDate.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/25.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import SwiftDate

extension DateInRegion {
    func toRelativeCurrentLocal() -> String {
        return toRelative(locale: Locales.current)
    }
}
