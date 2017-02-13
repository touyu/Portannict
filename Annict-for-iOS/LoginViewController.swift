//
//  LoginViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit
import SafariServices

import APIKit


// MARK: - LoginViewController

class LoginViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func tapedLoginButton(_ sender: UIButton) {
        guard let url = AnnictConsts.oauthURL() else { return }
        self.openSafariViewController(url: url)
    }
    
    fileprivate func openSafariViewController(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
        
        // Notification
        var observer: NSObjectProtocol!
        observer = NotificationCenter.default.addObserver(forName: .safariViewControllerCloseNotification, object: nil, queue: nil, using: { notification in
            NotificationCenter.default.removeObserver(observer)
            safariViewController.dismiss(animated: true, completion: nil)
            
            guard let code = notification.object as? String else { return }
            self.sendOauthToken(code: code)
        })
    }
    
    fileprivate func sendOauthToken(code: String) {
        let request = AnnictAPI.OauthToken(code: code)
        AnnictAPIClient.send(request) { response in
            switch response {
            case .success(let result):
                AnnictConsts.accessToken = result.accessToken
                
                // 画面遷移
                if !AnnictConsts.accessToken.isEmpty {
                    let annictTabBarController = AnnictTabBarController.instantiate(withStoryboard: "AnnictMeWorks")
                    self.present(annictTabBarController, animated: false, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
