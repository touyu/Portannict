//
//  AnnictConsts.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import Foundation

class AnnictConsts {
    
    static let rootURI = "https://api.annict.com"
    
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    
    static var clientID: String {
        guard let clientID = ProcessInfo.processInfo.environment["annict_client_id"] else {
            assertionFailure("env['annict_client_id'] is not set.")
            return ""
        }
        return clientID
    }
    
    static var clientSecret: String {
        guard let clientID = ProcessInfo.processInfo.environment["annict_client_secret"] else {
            assertionFailure("env['annict_client_secret'] is not set.")
            return ""
        }
        return clientID
    }
}
