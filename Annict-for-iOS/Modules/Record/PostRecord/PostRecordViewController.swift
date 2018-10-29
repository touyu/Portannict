//
//  PostRecordViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class PostRecordViewController: UIViewController, StoryboardView {
    typealias Reactor = PostRecordViewReactor
    
    let transitioner = PostRecordTransitioningDelegate()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:))))
    }

    func bind(reactor: Reactor) {

    }
    
    @objc private func handleGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: sender.view)
        
        switch sender.state {
        case .began:
            break
        case .changed:
            view.frame.origin.y += translation.y
            view.frame.size.height = UIScreen.main.bounds.height - view.frame.origin.y
            sender.setTranslation(.zero, in: view)
        case .cancelled:
            break
        case .ended:
            if view.frame.origin.y > 500 {
                dismiss(animated: true, completion: nil)
                return
            }
            
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0,
                           options: [.curveEaseOut, .allowUserInteraction],
                           animations: { [weak self] in
                            guard let self = self else { return }
                            let v = sender.velocity(in: self.view).y
                            let y = self.view.frame.origin.y + [-100, 0, 100].near(by: v)
                            self.view.frame.origin.y = [80, 400].near(by: y)
                            self.view.frame.size.height = UIScreen.main.bounds.height - self.view.frame.origin.y
                }, completion: nil)
        default:
            break
        }
    }
}

extension Array where Element: Comparable & SignedNumeric {
    func near(by e: Element) -> Element {
        let index = map { abs($0 - e) }.enumerated().min(by: { $0.element < $1.element })!.offset
        return self[index]
    }
}
