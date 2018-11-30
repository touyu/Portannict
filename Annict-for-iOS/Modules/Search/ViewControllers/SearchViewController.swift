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
    
    @IBOutlet private weak var topView: UIView!
    
    private var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: SearchResultViewController.loadStoryboard())
        sc.searchBar.searchBarStyle = .minimal
        sc.dimsBackgroundDuringPresentation = false
        return sc
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView.addSubview(searchController.searchBar)
        searchController.searchBar.sizeToFit()
        
//        searchController.searchBar.rx
//
//
//        searchController.searchBar.rx
//            .cancelButtonClicked
//            .delay(0.2, scheduler: MainScheduler.instance)
//            .subscribe(onNext: { [unowned self] _ in
////                self.searchController.searchBar.frame.size.width = self.topView.bounds.width - 8
//                self.view.setNeedsLayout()
//                self.view.layoutIfNeeded()
//            })
//            .disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        searchController.searchBar.frame.size.width = topView.bounds.width - 8
    }
}
