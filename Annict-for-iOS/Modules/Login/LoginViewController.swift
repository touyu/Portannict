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
import RxGesture

final class LoginViewController: UIViewController, StoryboardView {
    typealias Reactor = LoginViewReactor

    var disposeBag = DisposeBag()

    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var termsOfUseLabel: UILabel!
    @IBOutlet private weak var loginSwitch: UISwitch!

    private let fetchedCode = PublishRelay<String>()

    override func viewDidLoad() {
        super.viewDidLoad()

        logoImageView.layer.cornerRadius = 32
        logoImageView.layer.smoothCorners = true

        loginButton.layer.cornerRadius = 8
        loginButton.rx.tap
            .subscribe(onNext: tappedLoginButton)
            .disposed(by: disposeBag)

        termsOfUseLabel.attributedText = "利用規約に同意する"
            .attr
            .foregroundColor(.gray)
            .range(of: "利用規約") {
                $0.foregroundColor(UIColor.pa.blue)
                $0.underlineStyle(.single)
                $0.underlineColor(UIColor.pa.blue)
            }
            .apply()

        termsOfUseLabel.rx
            .tapGesture()
            .subscribe(onNext: { [weak self] recognizer in
                self?.openTermsOfService()
            })
            .disposed(by: disposeBag)

        loginSwitch.rx.isOn
            .subscribe(onNext: { [weak self] isOn in
                self?.loginButton.isEnabled = isOn
                self?.loginButton.alpha = isOn ? 1 : 0.5
            })
            .disposed(by: disposeBag)
    }

    func bind(reactor: Reactor) {
        fetchedCode
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

    private func openTermsOfService() {
        guard let url = URL(string: "https://touyu.github.io/Annict-for-iOS-Website/rule/") else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}
