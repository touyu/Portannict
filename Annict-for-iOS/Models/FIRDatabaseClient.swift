//
//  FIRDatabaseClient.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/03/04.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import Firebase


// MARK: - FIRDatabaseClient

class FIRDatabaseClient {
    
    fileprivate let reference = FIRDatabase.database().reference()

    func getStringValue(path: String, completionHandler: @escaping (_ value: String) -> Void) {
        self.getValue(path: path, completionHandler: completionHandler)
    }
    
    func getBoolValue(path: String, completionHandler: @escaping (_ value: Bool) -> Void) {
        self.getValue(path: path, completionHandler: completionHandler)
    }
    
    fileprivate func getValue<T>(path: String, completionHandler: @escaping (_ value: T) -> Void) {
        let reference = self.reference.child(path)
        reference.observeSingleEvent(of: .value, with: { snap in
            guard let value = snap.value as? T else {
                return
            }
            print("getValue: \(value)")
            completionHandler(value)
        })
    }
}
