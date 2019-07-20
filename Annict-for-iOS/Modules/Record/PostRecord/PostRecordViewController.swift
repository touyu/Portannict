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
import PanModal

final class PostRecordViewController: UIViewController, StoryboardView {
    typealias Reactor = PostRecordViewReactor
    
    var disposeBag = DisposeBag()

    @IBOutlet private weak var episodeTitleLabel: UILabel!
    @IBOutlet private weak var recordButton: UIButton!
    @IBOutlet private weak var textView: PlaceholderTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

    func bind(reactor: Reactor) {
        recordButton.rx.tap
            .withLatestFrom(textView.rx.text)
            .map { Reactor.Action.record($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state.map { $0.episode.numberAndTitle }
            .distinctUntilChanged()
            .bind(to: episodeTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isRecordingSuccess }
            .filter { $0 }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.textView.resignFirstResponder()
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func handleGesture(_ sender: UIPanGestureRecognizer) {
        panModalTransition(to: .longForm)
    }
}

extension PostRecordViewController {
    static func presentPanModal(fromVC: UIViewController, reactor: Reactor) {
        let vc = PostRecordViewController.loadStoryboard(reactor: reactor)
        fromVC.presentPanModal(vc)
    }
}

extension PostRecordViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return textView
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(350)
    }
    
    func willRespond(to panModalGestureRecognizer: UIPanGestureRecognizer) {
        textView.resignFirstResponder()
    }
}

extension PostRecordViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        panModalTransition(to: .longForm)
        return true
    }
}

extension Array where Element: Comparable & SignedNumeric {
    func near(by e: Element) -> Element {
        let index = map { abs($0 - e) }.enumerated().min(by: { $0.element < $1.element })!.offset
        return self[index]
    }
}
