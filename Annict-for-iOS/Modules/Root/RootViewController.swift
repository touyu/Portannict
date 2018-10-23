//
//  RootViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class RootViewController: UIViewController, StoryboardView {
    typealias Reactor = RootViewReactor

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        reactor = Reactor()
    }

    func bind(reactor: RootViewReactor) {
        reactor.state.map { $0.loginState }
            .subscribe(onNext: loginRouting)
            .disposed(by: disposeBag)
    }

    private(set) var currentViewController: UIViewController? {
        didSet {
            guard let vc = currentViewController else { return }
            addChild(vc)
            vc.view.frame = view.bounds
            view.addSubview(vc.view)
            vc.didMove(toParent: self)

            guard let oldVC = oldValue else { return }
            view.sendSubviewToBack(vc.view)
            UIView.transition(
                from: oldVC.view,
                to: vc.view,
                duration: 0.4,
                options: .transitionCrossDissolve) { [weak oldVC] _ in
                    oldVC?.willMove(toParent: nil)
                    oldVC?.view.removeAll()
                    oldVC?.removeFromParent()
                    oldVC = nil
            }
        }
    }

    private func loginRouting(state: Reactor.LoginState) {
        switch state {
        case .logout:
            currentViewController = LoginViewController.loadStoryboard()
        case .login:
            currentViewController = UIViewController()
        }
    }
}
