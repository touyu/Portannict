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
import PKHUD

final class PostRecordViewController: UIViewController, StoryboardView {
    typealias Reactor = PostRecordViewReactor
    
    var disposeBag = DisposeBag()

    @IBOutlet private weak var episodeTitleLabel: UILabel!
    @IBOutlet private weak var recordButton: UIButton!
    @IBOutlet private weak var textView: PlaceholderTextView!
    @IBOutlet private weak var ratingStateView: RatingStatusTagsView!
    @IBOutlet private weak var twitterShareButton: RadioButton!
    @IBOutlet private weak var twitterShareLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordButton.circleFilter()
        recordButton.configure(icon: .paperAirplane, size: 22)
        
        textView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

    func bind(reactor: Reactor) {
        recordButton.rx.tap
            .do(onNext: { _ in
                HUD.showToFront(.labeledProgress(title: "送信中", subtitle: nil))
            })
            .map { [unowned self] in
                Reactor.Action.record(self.textView.text,
                                      self.ratingStateView.selectedRatingState)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        twitterShareButton.rx.isOn
            .map { Reactor.Action.setShouldShareTwitter($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        twitterShareLabel.rx.tapGesture()
            .skip(1)
            .subscribe(onNext: { [weak self] _ in
                self?.twitterShareButton.isOn.toggle()
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.episode.numberAndTitle }
            .distinctUntilChanged()
            .bind(to: episodeTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isRecordingSuccess }
            .filter { $0 }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                HUD.hide()
                self?.textView.resignFirstResponder()
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.shouldShareTwitter }
            .take(1)
            .bind(to: twitterShareButton.rx.isOn)
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
        return .contentHeight(440)
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
