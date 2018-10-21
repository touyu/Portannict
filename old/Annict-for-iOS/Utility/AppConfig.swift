//
//  AppConfig.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/19.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import Foundation

class AppConfig {
    static func isTesting() -> Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
}
