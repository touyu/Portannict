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

        tabBar.tintColor = UIColor(hex: 0x2f2f2f)
        tabBar.unselectedItemTintColor = UIColor.lightGray

        for vc in viewControllers ?? [] {
            guard let nc = vc as? UINavigationController else {
                continue
            }

            if let homeVC = nc.viewControllers.first as? HomeViewController {
                homeVC.reactor = reactor?.homeForReactor
            }
        }
    }

    func bind(reactor: Reactor) {
        
    }
}
