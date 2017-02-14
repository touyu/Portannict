//
//  AnnictSearchViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/14.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class AnnictSearchViewController: UIViewController {
    
    @IBOutlet dynamic fileprivate weak var searchBar: UISearchBar!
    @IBOutlet dynamic fileprivate weak var tableView: UITableView!
    
    fileprivate var popularAnimes: [AnnictWorkResponse] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "search".localized(withTableName: "AnnictBaseLocalizable")
        searchBar.delegate = self
        
        self.initTableView()
        
        let indicator = self.initIndicatorView()
        self.getPopularAnime() { _ in
            indicator.stopAnimating()
        }
    }
    
    fileprivate func initTableView() {
        self.tableView.dataSource = self
//        self.tableView.delegate = self
        self.tableView.register(cellType: AnnictMeWorkCell.self)
//        self.initRefreshControl()
    }
    
    fileprivate func getPopularAnime(completionHandler: (() -> Void)? = nil) {
        let request = AnnictAPI.GetRecords(perPage: 20)
        AnnictAPIClient.send(request) { response in
            switch response {
            case .success(let value):
                // 最近見られたアニメから重複を無くして返す
                self.popularAnimes = value.records.map { $0.work }.reduce([]) {$0.0.map{$0.id}.contains($0.1.id) ? $0.0 : $0.0 + [$0.1] }
                completionHandler?()
            case .failure(let error):
                print(error)
                completionHandler?()
            }
        }
    }
    
    fileprivate func initIndicatorView() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.center = CGPoint(x: view.bounds.midX, y: 24 + searchBar.bounds.height)
        indicator.color = .annictPink
        view.addSubview(indicator)
        indicator.startAnimating()
        return indicator
    }
}

extension AnnictSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularAnimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: AnnictMeWorkCell.self, for: indexPath)
        cell.set(work: popularAnimes[indexPath.row])
        return cell
    }
}

extension AnnictSearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
        if searchBar.text?.isEmpty ?? true {
            self.getPopularAnime()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            // 初期化
            self.popularAnimes = []
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
        // 初期化
        self.popularAnimes = []
        
        self.searchAnime(title: searchBar.text)
    }
    
    fileprivate func searchAnime(title: String?) {
        let request = AnnictAPI.GetWorks(filterTitle: title)
        AnnictAPIClient.send(request) { response in
            switch response {
            case .success(let value):
                self.popularAnimes = value.works
            case .failure(let error):
                print(error)
            }
        }
    }
}
