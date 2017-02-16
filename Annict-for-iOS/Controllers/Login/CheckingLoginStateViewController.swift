//
//  CheckingLoginStateViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit


// MARK: - CheckingLoginStateViewController

class CheckingLoginStateViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if AnnictConsts.accessToken.isEmpty {
            let loginVC = LoginViewController.instantiate(withStoryboard: "Login")
            self.present(loginVC, animated: false, completion: nil)
        } else {
//            let annictMeWorksNC = AnnictMeWorksNavigationController.instantiate(withStoryboard: "AnnictMeWorks")
//            self.present(annictMeWorksNC, animated: false, completion: nil)
            
            let annictTabBarController = AnnictTabBarController.instantiate(withStoryboard: "AnnictMeWorks")
            self.present(annictTabBarController, animated: false, completion: nil)
        }
    }
}
