//
//  ProfileWorksViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/01/16.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import XLPagerTabStrip

protocol ScrollViewProvider {
    func provideScrollView() -> UIScrollView?
}

protocol ChildPagerTabStripDelegate: class {
    func scrollViewWillDisplay(_ scrollView: UIScrollView)
    func scrollViewDidScrolled(_ scrollView: UIScrollView)
}

class ChildPagerViewController: UIViewController, ScrollViewProvider, UIScrollViewDelegate {
    weak var delegate: ChildPagerTabStripDelegate?

    private var observation: NSKeyValueObservation?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        observation?.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        observeContentSize()
        if let scrollView = provideScrollView() {
            scrollView.delegate = self
            delegate?.scrollViewWillDisplay(scrollView)
        }
    }

    func provideScrollView() -> UIScrollView? {
        fatalError("Unimplemented provideScrollView()")
    }

    private func observeContentSize() {
        observation = provideScrollView()?.observe(\.contentSize, options: [.new]) { collectionView, value in
            print(value.newValue)
            print(collectionView.frame.size)
            guard let newValue = value.newValue else { return }
            let newBottomInset = collectionView.frame.size.height - newValue.height
            if newBottomInset > 0 {
                collectionView.contentInset.bottom = collectionView.frame.size.height - newValue.height
            } else {
                collectionView.contentInset.bottom = 0
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScrolled(scrollView)
    }
}

final class ProfileWorksViewController: ChildPagerViewController, StoryboardView {
    typealias Reactor = ProfileWorksViewReactor

    var disposeBag = DisposeBag()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(cellTypes: ProfileWorkCollectionViewCell.self)
    }

    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .take(1)
            .map { Reactor.Action.fetch }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        collectionView.rx.setDataSource(self)
            .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        collectionView.rx.reachedBottom
            .throttle(1, latest: false, scheduler: MainScheduler.instance)
            .map { Reactor.Action.loadMore }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.works }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    override func provideScrollView() -> UIScrollView? {
        return collectionView
    }
}

extension ProfileWorksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let reactor = reactor else { return 0 }
        return reactor.currentState.works.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: ProfileWorkCollectionViewCell.self, for: indexPath)
        guard let reactor = reactor else { return cell }
        let work = reactor.currentState.works[indexPath.item]
        cell.configure(work: work)
        cell.setHeroID("work_image_\(indexPath.item)")
        return cell
    }
}

extension ProfileWorksViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let mergin: CGFloat = 24
        let column: CGFloat = 3
        let width = (collectionView.bounds.width - mergin * (column + 1)) / column
        return CGSize(width: width, height: width * 1.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let reactor = reactor else { return }
        let work = reactor.currentState.works[indexPath.item]
        let vc = WorkViewController.loadStoryboard()
        vc.reactor = .init(work: work, heroID: "work_image_\(indexPath.item)")
        vc.hero.isEnabled = true
        present(vc, animated: true, completion: nil)
    }
}

extension ProfileWorksViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: reactor?.statusState.localizedText)
    }
}
