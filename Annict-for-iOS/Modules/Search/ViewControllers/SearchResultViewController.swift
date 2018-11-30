//
//  SearchResultViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/30.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class SearchResultViewController: UIViewController, StoryboardView {
    typealias Reactor = SearchResultViewReactor

    var disposeBag = DisposeBag()

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareTableView()
    }

    func bind(reactor: Reactor) {
        reactor.state.map { $0.works }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] works in
                print(works)
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func prepareTableView() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        tableView.register(SearchResultWorkCell.self)
    }
}

extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reactor?.currentState.works.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(classType: SearchResultWorkCell.self, for: indexPath)
        guard let work = reactor?.currentState.works[indexPath.row] else { return .init() }
        cell.configure(imageURL: work.image?.twitterAvatarUrl, title: work.title)
        return cell
    }
}

extension SearchResultViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        view.isHidden = false
        guard let text = searchController.searchBar.text else { return }
        guard !text.isEmpty else { return }
        reactor?.action.onNext(.search(text))
    }
}
