//
//  StatusBarManager.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/04/01.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class StatusBarManager {
    static let shared = StatusBarManager()
    private init() { }
    
    var isStatusBarHidden: Bool = false
    
    func hideStatusBar() {
        isStatusBarHidden = true
        updateStatusBar()
    }
    
    func showStatusBar() {
        isStatusBarHidden = false
        updateStatusBar()
    }
    
    private func updateStatusBar() {
        UIView.animate(withDuration: 0.35) {
            let topVC = UIApplication.topViewController()
            topVC?.setNeedsStatusBarAppearanceUpdate()
        }
    }
}

protocol StatusBarAnimatable {
    var statusBarManager: StatusBarManager { get }
}

extension StatusBarAnimatable {
    var statusBarManager: StatusBarManager {
        return .shared
    }
}

extension StatusBarAnimatable where Self: UIViewController {
    func hideStatusBar() {
        statusBarManager.hideStatusBar()
//        statusBarManager.isStatusBarHidden = true
//        UIView.animate(withDuration: 0.35) { [weak self] in
//            self?.setNeedsStatusBarAppearanceUpdate()
//        }
    }
    
    func showStatusBar() {
        statusBarManager.showStatusBar()
//        statusBarManager.isStatusBarHidden = false
        
//        UIView.animate(withDuration: 0.35) { [weak self] in
//            self?.setNeedsStatusBarAppearanceUpdate()
//        }
    }
}

class StatusBarAnimatableViewController: UIViewController {
    let statusBarManager = StatusBarManager.shared
    
    override var prefersStatusBarHidden: Bool {
        return statusBarManager.isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    func hideStatusBar() {
        statusBarManager.isStatusBarHidden = true
        UIView.animate(withDuration: 0.35) { [weak self] in
            self?.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func showStatusBar() {
        statusBarManager.isStatusBarHidden = false
        UIView.animate(withDuration: 0.35) { [weak self] in
            self?.setNeedsStatusBarAppearanceUpdate()
        }
    }
}
