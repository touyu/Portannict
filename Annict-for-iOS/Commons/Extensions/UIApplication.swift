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
    
    static func topViewController() -> UIViewController? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        guard let rootVC = appDelegate.window?.rootViewController else { return nil }
        return rootVC.topViewController()
    }
}

extension UIViewController {
    func topViewController() -> UIViewController {
        if let root = self as? RootViewController {
            return root.currentViewController?.topViewController() ?? self
        } else if let tab = self as? UITabBarController {
            if let vc = tab.selectedViewController {
                return vc.topViewController()
            }
        } else if let navi = self as? UINavigationController {
            if let vc = navi.viewControllers.last {
                return vc.topViewController()
            }
        } else if let presented = self.presentedViewController {
            return presented.topViewController()
        }
        return self
    }
}
