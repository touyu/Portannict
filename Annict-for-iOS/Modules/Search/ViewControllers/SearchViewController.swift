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
    }

    func bind(reactor: Reactor) {
//        rx.viewWillAppear
//            .take(1)
//            .map { Reactor.Action.fetchWorksOfThisTerm }
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//
//        reactor.state.map { $0.works }
//            .distinctUntilChanged()
//            .subscribe(onNext: { [weak self] _ in
//                self?.collectionView.reloadData()
//            })
//            .disposed(by: disposeBag)
    }

    private func prepareNavigationBar() {
        navigationItem.titleView = searchController.searchBar
        navigationItem.titleView?.frame = searchController.searchBar.frame
        navigationController?.navigationBar.transparent()
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
