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

final class SearchViewController: UIViewController, StoryboardView {
    typealias Reactor = SearchViewReactor

    @IBOutlet private weak var collectionView: UICollectionView!

    private var resultController: SearchResultViewController = {
        let vc = SearchResultViewController.loadStoryboard()
        vc.reactor = SearchResultViewReactor()
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

        reactor = Reactor()

        prepareNavigationBar()
        prepareCollectionView()
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

    private func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(cellTypes: SeasonWorksCollectionViewCell.self)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RecommendSeasonSection.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: SeasonWorksCollectionViewCell.self, for: indexPath)
        guard let reactor = reactor else { return cell }
        cell.reactor = reactor.cellReactors[indexPath.item]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cells = collectionView.visibleCells.compactMap { $0 as? SeasonWorksCollectionViewCell }
        cells.enumerated().forEach { index, cell in
            let y = scrollView.convert(cell.frame.origin, to: view).y - scrollView.frame.origin.y - 16
            if abs(scrollView.contentOffset.y - (-y)) < 10 {
                cell.setContentOffsetY(max(-y, 0) * 0.1)
            } else {
                cell.setContentOffsetY(max(-y + scrollView.bounds.height / 2, 0) * 0.1)
            }
        }
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! UserWorkCollectionViewCell
//        let vc = WorkViewController.loadStoryboard()
//        vc.prepareHero { vc in
//            vc.hero.isEnabled = true
//            vc.hero.modalAnimationType = .fade
//            vc.imageView.image = cell.imageView.image
//            vc.imageView.hero.id = cell.imageView.hero.id
//        }
//        vc.reactor = WorkViewReactor(title: reactor?.currentState.works[indexPath.item].title ?? "",
//                                     titleLabelHeroID: cell.titleLabel.hero.id ?? "")
//        present(vc, animated: true, completion: nil)
//    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
}
