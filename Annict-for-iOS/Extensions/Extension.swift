//
//  Extension.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/10/19.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

extension StatusState {
    func localized() -> String {
        return rawValue.localized(withTableName: "AnnictBaseLocalizable")
    }
}
