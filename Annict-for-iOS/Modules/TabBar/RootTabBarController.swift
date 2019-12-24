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
            if let homeVC = vc as? HomeViewController {
                homeVC.reactor = reactor?.reactorForHome
                let homeImage = UIImage.icon(.houseFill, ofSize: 22, color: .black, baselineOffset: -6)
                let homeSelectedImage = UIImage.icon(.houseFill, ofSize: 22, color: .black, baselineOffset: -6)
                homeVC.tabBarItem = UITabBarItem(title: nil, image: homeImage, selectedImage: homeSelectedImage)
            }
            
            if let recordVC = vc as? RecordViewController {
                recordVC.reactor = reactor?.reactorForRecord
                let recordImage = UIImage.icon(.pencilCircleFill, ofSize: 24, color: .black, baselineOffset: -6)
                let recordSelectedImage = UIImage.icon(.pencilCircleFill, ofSize: 24, color: .black, baselineOffset: -6)
                recordVC.tabBarItem = UITabBarItem(title: nil, image: recordImage, selectedImage: recordSelectedImage)
            }
            
            if let profileVC = vc as? ProfileViewController {
                profileVC.reactor = reactor?.reactorForProfile
                let profileImage = UIImage.icon(.personFill, ofSize: 24, color: .black, baselineOffset: -6)
                let profileSelectedImage = UIImage.icon(.personFill, ofSize: 24, color: .black, baselineOffset: -6)
                profileVC.tabBarItem = UITabBarItem(title: nil, image: profileImage, selectedImage: profileSelectedImage)
            }
            
            if let nc = vc as? UINavigationController {
                if let searchVC = nc.viewControllers.first as? SearchViewController {
                    searchVC.reactor = reactor?.reactorForSearch
                    let searchImage = UIImage.icon(.magnifyingglassCircleFill, ofSize: 24, color: .black, baselineOffset: -6)
                    let searchSelectedImage = UIImage.icon(.magnifyingglassCircleFill, ofSize: 24, color: .black, baselineOffset: -6)
                    searchVC.tabBarItem = UITabBarItem(title: nil, image: searchImage, selectedImage: searchSelectedImage)
                }
            }
        }
    }
    
    func bind(reactor: Reactor) {
        
    }
}
