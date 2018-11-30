//
//  SearchViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/30.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import RxSwift

final class SearchViewController: UIViewController {

    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: SearchResultViewController.loadStoryboard())
        sc.searchBar.searchBarStyle = .minimal
        sc.searchResultsUpdater = self
        sc.hidesNavigationBarDuringPresentation = false
        sc.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        return sc
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = searchController.searchBar
        navigationItem.titleView?.frame = searchController.searchBar.frame
        navigationController?.navigationBar.transparent()
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
}
