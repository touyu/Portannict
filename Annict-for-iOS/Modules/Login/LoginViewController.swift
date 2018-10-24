//
//  LoginViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import SafariServices

final class LoginViewController: UIViewController, StoryboardView {
    typealias Reactor = LoginViewReactor

    var disposeBag = DisposeBag()

    @IBOutlet private weak var loginButton: UIButton!
    
    private let fetchedCode = PublishRelay<String>()

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.rx.tap
            .subscribe(onNext: tappedLoginButton)
            .disposed(by: disposeBag)
    }

    func bind(reactor: Reactor) {
        fetchedCode
            .map { Reactor.Action.fetchOauthToken($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.oauthToken }
            .distinctUntilChanged()
            .filterNil()
            .do(onNext: {
                print($0)
            })
            .map { Reactor.Action.login($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.loginSuccess }
            .distinctUntilChanged()
            .filter { $0 }
            .subscribe(onNext: { _ in print("login success") })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.error }
            .filterNil()
            .subscribe(onNext: { print("Error: ", $0) })
            .disposed(by: disposeBag)
    }

    private func tappedLoginButton() {
        guard let url = Constants.oauthURL else { return }
        showSafariViewController(url: url)
    }

    private func showSafariViewController(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
        
        NotificationCenter.default.rx.notification(.safariViewControllerCloseNotification)
            .do(onNext: { _ in
                safariViewController.dismiss(animated: true, completion: nil)
            })
            .map { $0.object as? String }
            .filterNil()
            .bind(to: fetchedCode)
            .disposed(by: disposeBag)
    }
}
