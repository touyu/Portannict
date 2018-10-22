//
//  ViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/21.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, StoryboardView {
    typealias Reactor = ViewReactor
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var modalButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = ServiceProvider()
        reactor = Reactor(provider: provider)
    }

    func bind(reactor: Reactor) {
        button.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { "\($0.value)" }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        modalButton.rx.tap
            .map { reactor.provider }
            .subscribe(onNext: { [weak self] provider in
                self?.show(provider: provider)
            })
            .disposed(by: disposeBag)
    }
    
    private func show(provider: ServiceProviderType) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController
        vc.reactor = ModalViewReactor(provider: provider)
        present(vc, animated: true, completion: nil)
    }
}

