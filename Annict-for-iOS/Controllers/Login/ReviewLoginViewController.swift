//
//  ReviewLoginViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/03/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class ReviewLoginViewController: UIViewController {
    
    @IBOutlet dynamic fileprivate weak var IDTextField: UITextField!
    @IBOutlet dynamic fileprivate weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IDTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func tapedLoginButton(_ sender: Any) {
        guard let testID = ProcessInfo.processInfo.environment["test_annict_id"] else {
            assertionFailure("env['test_annict_id'] is not set.")
            return
        }
        
        guard let testPass = ProcessInfo.processInfo.environment["test_annict_pass"] else {
            assertionFailure("env['test_annict_pass'] is not set.")
            return
        }
        
        if IDTextField.text == testID && passwordTextField.text == testPass {
            guard let testAccessToken = ProcessInfo.processInfo.environment["test_annict_access_token"] else {
                assertionFailure("env['test_annict_access_token'] is not set.")
                return
            }
            AnnictConsts.accessToken = testAccessToken
            let annictTabBarController = AnnictTabBarController.instantiate(withStoryboard: "AnnictMeWorks")
            self.present(annictTabBarController, animated: false, completion: nil)
        } else {
            print("ERROR: Test Login")
        }
    }
}

extension ReviewLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
