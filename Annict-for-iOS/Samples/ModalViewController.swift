//
//  ModalViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/22.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

final class ModalViewController: UIViewController, StoryboardView {
    typealias Reactor = ModalViewReactor
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    func bind(reactor: Reactor) {
        increaseButton.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { "\($0.value)" }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
    }
}
