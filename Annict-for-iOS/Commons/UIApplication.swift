//
//  UIApplication.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

extension UIApplication {
    static var rootViewController: RootViewController? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.window?.rootViewController as? RootViewController
    }
}
