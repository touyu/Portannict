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
import SafariServices

final class LoginViewController: UIViewController, StoryboardView {
    typealias Reactor = LoginViewReactor

    var disposeBag = DisposeBag()

    @IBOutlet private weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.rx.tap
            .subscribe(onNext: tappedLoginButton)
            .disposed(by: disposeBag)
    }

    func bind(reactor: Reactor) {

    }

    private func tappedLoginButton() {
        guard let url = Constants.oauthURL else { return }
        showSafariViewController(url: url)
    }

    private func showSafariViewController(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}
