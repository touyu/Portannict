//
//  ReviewLoginViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/03/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import Keys

class ReviewLoginViewController: UIViewController {
    
    @IBOutlet dynamic fileprivate weak var IDTextField: UITextField!
    @IBOutlet dynamic fileprivate weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IDTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func tapedLoginButton(_ sender: Any) {
        if IDTextField.text == AnnictForIOSKeys().annictIDForReview && passwordTextField.text == AnnictForIOSKeys().annictPassForReview {
            AnnictConsts.accessToken = AnnictForIOSKeys().annictAccessTokenForReview
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
