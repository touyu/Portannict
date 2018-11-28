//
//  StatusState.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/28.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import Foundation

extension StatusState {
    static var values: [StatusState] {
        return [.watching, .wannaWatch, .watched, .onHold, .stopWatching]
    }
    
    var localizedText: String {
        switch self {
        case .watching:
            return "見てる"
        case .wannaWatch:
            return "見たい"
        case .watched:
            return "見た"
        case .onHold:
            return "中断"
        case .stopWatching:
            return "中止"
        case .noState, .__unknown:
            return ""
        }
    }
}
