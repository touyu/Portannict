//
//  SearchViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/30.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit

final class SearchViewController: UIViewController, StoryboardView {
    typealias Reactor = SearchViewReactor

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var seasonLabel: UILabel!
    private var calendarButton: UIButton = {
        let button = UIButton(imageType: .calendar)
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor(hex: 0xFA5871)
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        button.applyFABShadow()
        return button
    }()
    
    private let column: CGFloat = 3
    private let itemSpacing: CGFloat = 18

    private lazy var resultController: SearchResultViewController = {
        let vc = SearchResultViewController.loadStoryboard()
        vc.reactor = reactor?.reactorForResult()
        return vc
    }()

    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: resultController)
        sc.searchBar.searchBarStyle = .minimal
        sc.searchResultsUpdater = resultController
        sc.hidesNavigationBarDuringPresentation = false
        sc.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        return sc
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareNavigationBar()
        prepareCalendarButton()
        
        collectionView.register(cellTypes: ProfileWorkCollectionViewCell.self)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        calendarButton.updateShodowPath()
    }

    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .take(1)
            .map { Reactor.Action.fetchWorks }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        collectionView.rx.setDataSource(self)
            .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        collectionView.rx.triggeredPagination()
            .map { Reactor.Action.fetchMore }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        calendarButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                TermSettingViewController.presentPanModal(fromVC: self, reactor: reactor.reactorForTerm)
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.works }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)

        reactor.reactorForTerm.state.map { $0.selectedSeason }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] season in
                self?.seasonLabel.text = season.toString()
            })
            .disposed(by: disposeBag)
    }

    private func prepareNavigationBar() {
        navigationItem.titleView = searchController.searchBar
        navigationItem.titleView?.frame = searchController.searchBar.frame
        navigationController?.navigationBar.transparent()
    }

    private func prepareCalendarButton() {
        view.addSubview(calendarButton)
        calendarButton.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.bottom.equalTo(view.snp.bottomMargin).offset(-20)
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let reactor = reactor else { return 0 }
        return reactor.currentState.works.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: ProfileWorkCollectionViewCell.self, for: indexPath)
        guard let reactor = reactor else { return cell }
        let work = reactor.currentState.works[indexPath.item]
        cell.configure(work: work)
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - itemSpacing * (column + 1)) / column
        return CGSize(width: width, height: width * 1.4 + 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: itemSpacing, bottom: 0, right: itemSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let reactor = reactor?.reactorForWork(index: indexPath.item) else { return }
        WorkViewController.presentPanModal(fromVC: self, reactor: reactor)
    }
}

enum RecommendSeasonSection: CaseIterable {
    case present
    case previous
    case next
    case previous2
    case previous3
    case previous4

    var title: String {
        switch self {
        case .present:
            return "今期のアニメ"
        case .previous:
            return "前期のアニメ"
        case .next:
            return "来期のアニメ"
        case .previous2, .previous3, .previous4:
            return "\(season.year)年 \(season.name.localizedText)アニメ"
        }
    }

    var season: Season {
        let current = Season.current
        switch self {
        case .present:
            return current
        case .previous:
            return current.previous()
        case .next:
            return current.next()
        case .previous2:
            return current.previous(2)
        case .previous3:
            return current.previous(3)
        case .previous4:
            return current.previous(4)
        }
    }
}
