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
import SwiftyAttributedString
import RxSwift
import RxCocoa
import RxGesture


// MARK: - LoginViewController

class LoginViewController: UIViewController {
    
    @IBOutlet dynamic private weak var loginButton: UIButton!
    @IBOutlet dynamic private weak var loginSwitch: UISwitch!
    @IBOutlet dynamic private weak var termsOfUseLabel: UILabel!

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let url = AnnictConsts.oauthURL() else { return }
                self?.openSafariViewController(url: url)
            })
            .disposed(by: disposeBag)
        
        loginSwitch.rx.isOn
            .subscribe(onNext: { [weak self] isOn in
                self?.loginButton.isEnabled = isOn
                self?.loginButton.alpha = isOn ? 1 : 0.5
            })
            .disposed(by: disposeBag)
        
        termsOfUseLabel.rx
            .tapGesture()
            .subscribe(onNext: { [weak self] recognizer in
                self?.openTermsOfService()
            })
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initUI()
    }
    
    private func initUI() {
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 4
        
        termsOfUseLabel.attributedText = termsOfUseLabel.text?.add(attribute: Attribute(values: [.foregroundColor(.annictBlue),
                                                                                                 .underlineStyle(1)],
                                                                                        range: .portion(of: .string("terms_of_use".localized()))))
    }
    
    private func openSafariViewController(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
        
        NotificationCenter.default.rx
            .notification(.safariViewControllerCloseNotification)
            .subscribe(onNext: { [weak self] notification in
                safariViewController.dismiss(animated: true, completion: nil)
                
                guard let code = notification.object as? String else { return }
                self?.sendOauthToken(code: code)
            })
            .disposed(by: disposeBag)
    }
    
    private func sendOauthToken(code: String) {
        let request = AnnictAPI.OauthToken(code: code)
        AnnictAPIClient.send(request) { [weak self] response in
            switch response {
            case .success(let result):
                AnnictConsts.accessToken = result.accessToken
                
                // 画面遷移
                if !AnnictConsts.accessToken.isEmpty {
                    let annictTabBarController = AnnictTabBarController.instantiate(withStoryboard: "AnnictMeWorks")
                    self?.present(annictTabBarController, animated: false, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func openTermsOfService() {
        guard let url = URL(string: "https://touyu.github.io/Annict-for-iOS-Website/rule/") else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}
