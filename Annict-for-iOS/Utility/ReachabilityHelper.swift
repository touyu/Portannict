//
//  ReachabilityHelper.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/04/02.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import Reachability

//fileprivate let reachability = Reachability()!

//protocol ReachabilityHelperDelegate {
//    func whenReachable(reachability: Reachability)
//    func whenUnReachable(reachability: Reachability)
//}
//
//extension UIViewController: ReachabilityHelperDelegate {
////    open override func viewWillAppear(_ animated: Bool) {
////        super.viewWillAppear(animated)
////        
////        ReachabilityHelper.delegate = self
////    }
//    
//    func whenReachable(reachability: Reachability) {
//        ReachabilityLogger("whenReachable (\(type(of: self)))")
//    }
//    
//    func whenUnReachable(reachability: Reachability) {
//        ReachabilityLogger("whenUnreachable (\(type(of: self)))")
//    }
//}

class ReachabilityHelper {
    
    fileprivate static let reachability = Reachability()!
    
//    static var delegate: ReachabilityHelperDelegate? {
//        didSet {
//            reachability.whenReachable = { reachability in
//                self.delegate?.whenReachable(reachability: reachability)
//            }
//            
//            reachability.whenUnreachable = { reachability in
//                self.delegate?.whenUnReachable(reachability: reachability)
//            }
//        }
//    }
    
    class func configure() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(startObserving), name: .UIApplicationDidFinishLaunching, object: nil)
        notificationCenter.addObserver(self, selector: #selector(startObserving), name: .UIApplicationDidBecomeActive, object: nil)
        notificationCenter.addObserver(self, selector: #selector(stopObserving), name: .UIApplicationDidEnterBackground, object: nil)
    }
    
    class func observe(whenReachable: Reachability.NetworkReachable? = nil,
                       whenUnreachable: Reachability.NetworkReachable? = nil) {
        reachability.whenReachable = { reachability in
            ReachabilityLogger("whenReachable")
            whenReachable?(reachability)
        }
        
        reachability.whenUnreachable = { reachability in
            ReachabilityLogger("whenUnreachable")
            whenUnreachable?(reachability)
        }
    }
    
    @objc private class func startObserving() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc private class func stopObserving() {
        reachability.stopNotifier()
    }
}

func ReachabilityLogger(_ items: Any) {
    print("📲[Reachability]:", terminator: " ")
    print(items)
}
