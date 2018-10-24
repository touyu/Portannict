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

        reactor = Reactor(provider: ServiceProvider())
    }

    func bind(reactor: RootViewReactor) {
        reactor.state.map { $0.loginState }
            .filter { $0 == .logout }
            .map { _ in reactor.reactorForLogin() }
            .subscribe(onNext: showLoginVC)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.loginState }
            .filter { $0 == .login }
            .map { _ in reactor.reactorForHome() }
            .subscribe(onNext: showHomeVC)
            .disposed(by: disposeBag)
        
    }

    func setCurrentViewController(_ vc: UIViewController) {
        currentViewController = vc
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
    
    private func showLoginVC(reactor: LoginViewReactor) {
        currentViewController = LoginViewController.loadStoryboard(reactor: reactor)
    }
    
    private func showHomeVC() {
        currentViewController = HomeViewController.loadStoryboard()
    }
}
