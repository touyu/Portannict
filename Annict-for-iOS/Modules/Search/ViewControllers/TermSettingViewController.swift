//
//  TermSettingViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/26.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import PanModal

final class TermSettingViewController: UIViewController, StoryboardView {
    typealias Reactor = TermSettingViewReactor

    @IBOutlet private weak var pickerView: UIPickerView!
    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var thisTermButton: UIButton!
    @IBOutlet private weak var nextTermButton: UIButton!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.dataSource = self
        pickerView.delegate = self
    }

    func bind(reactor: Reactor) {
        doneButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                reactor.action.onNext(.selected(self.pickerView.selectedRow(inComponent: 0),
                                                self.pickerView.selectedRow(inComponent: 1)))
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        Observable.zip(rx.viewWillAppear,
                       reactor.state.map { $0.selectedSeason })
            .take(1)
            .map { $0.1 }
            .subscribe(onNext: { [weak self] season in
                self?.selectSeason(season)
            })
            .disposed(by: disposeBag)

        thisTermButton.rx.tap
            .map { Reactor.Action.selectedSeason(Season.current) }
            .subscribe(onNext: { [weak self] action in
                self?.reactor?.action.onNext(action)
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        nextTermButton.rx.tap
            .map { Reactor.Action.selectedSeason(Season.current.next()) }
            .subscribe(onNext: { [weak self] action in
                self?.reactor?.action.onNext(action)
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }

    private func selectSeason(_ season: Season) {
        guard let index1 = reactor!.currentState.years.firstIndex(of: season.year) else { return }
        guard let index2 = reactor!.currentState.seasons.firstIndex(of: season.name) else { return }
        pickerView.selectRow(index1, inComponent: 0, animated: true)
        pickerView.selectRow(index2, inComponent: 1, animated: true)
    }
}

extension TermSettingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return reactor!.currentState.years.count
        }
        return reactor!.currentState.seasons.count
    }
}

extension TermSettingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return reactor!.currentState.years[row].description
        }
        return reactor!.currentState.seasons[row].localizedText
    }
}

extension TermSettingViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(300)
    }

    static func presentPanModal(fromVC: UIViewController, reactor: Reactor) {
        let vc = TermSettingViewController.loadStoryboard(reactor: reactor)
        fromVC.presentPanModal(vc)
    }
}
