//
//  RootTabbarController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class RootTabBarController: UITabBarController, StoryboardView {
    typealias Reactor = RootTabBarReactor

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = UIColor(hex: 0xFA5871)
        tabBar.unselectedItemTintColor = UIColor(white: 0.8, alpha: 1)

        for vc in viewControllers ?? [] {
            print(vc)
            if let homeVC = vc as? HomeViewController {
                homeVC.reactor = reactor?.reactorForHome
            }
            
            if let recordVC = vc as? RecordViewController {
                recordVC.reactor = reactor?.reactorForRecord
            }
            
            if let profileVC = vc as? ProfileViewController {
                profileVC.reactor = reactor?.reactorForProfile
            }
            
            if let nc = vc as? UINavigationController {
                if let searchVC = nc.viewControllers.first as? SearchViewController {
                    searchVC.reactor = reactor?.reactorForSearch
                }
            }
        }
    }
    
    func bind(reactor: Reactor) {
        
    }
}
