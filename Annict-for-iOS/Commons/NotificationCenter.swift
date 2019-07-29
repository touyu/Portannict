//
//  NotificationCenter.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import Foundation

extension NotificationCenter {
    func single(forName name: NSNotification.Name?, object obj: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> Void) {
        var token: NSObjectProtocol!
        token = addObserver(forName: name, object: obj, queue: queue) { [weak self] notification in
            self?.removeObserver(token)
            block(notification)
        }
    }
}
