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
    
    fileprivate var sectionHeight: CGFloat = 40
    
    fileprivate var sectionTitle: String = "最近見られたアニメ" {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    fileprivate var popularAnimes: [AnnictWorkResponse] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "search".localized(withTableName: "AnnictBaseLocalizable")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        searchBar.delegate = self
        
        self.initTableView()
        
        let indicator = self.initIndicatorView()
        self.getPopularAnime() { _ in
            indicator.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    fileprivate func initTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(cellType: AnnictMeWorkCell.self)
        self.tableView.register(cellType: AnnictRecentlyAnimeSectionCell.self)
//        self.initRefreshControl()
    }
    
    fileprivate func getPopularAnime(completionHandler: (() -> Void)? = nil) {
        let request = AnnictAPI.GetRecords(perPage: 20)
        AnnictAPIClient.send(request) { response in
            switch response {
            case .success(let value):
                // 最近見られたアニメから重複を無くして返す
                self.popularAnimes = value.records.map { $0.work! }.reduce([]) {$0.0.map{$0.id}.contains($0.1.id) ? $0.0 : $0.0 + [$0.1] }
                completionHandler?()
            case .failure(let error):
                print(error)
                completionHandler?()
            }
        }
    }
    
    fileprivate func initIndicatorView() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.center = CGPoint(x: view.bounds.midX, y: 24 + searchBar.bounds.height + sectionHeight)
        indicator.color = .annictPink
        view.addSubview(indicator)
        indicator.startAnimating()
        return indicator
    }
}

extension AnnictSearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return popularAnimes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(with: AnnictRecentlyAnimeSectionCell.self, for: indexPath)
            cell.set(title: self.sectionTitle)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(with: AnnictMeWorkCell.self, for: indexPath)
            cell.set(work: popularAnimes[indexPath.row])
            return cell
        }
    }
}

extension AnnictSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return sectionHeight
        } else {
            return 97
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let annictDetailAnimeInfoVC = AnnictDetailAnimeInfoTabViewController.instantiate(withStoryboard: "AnnictWorks")
        annictDetailAnimeInfoVC.work = popularAnimes[indexPath.row]
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.pushViewController(annictDetailAnimeInfoVC, animated: true)
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
            self.sectionTitle = "最近見られたアニメ"
            self.popularAnimes = []
            let indicator = self.initIndicatorView()
            self.getPopularAnime() { _ in
                indicator.stopAnimating()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            // 初期化
            self.sectionTitle = ""
            self.popularAnimes = []
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
        // 初期化
        self.sectionTitle = "検索結果"
        self.popularAnimes = []
        
        let indicator = self.initIndicatorView()
        self.searchAnime(title: searchBar.text) { _ in
            indicator.stopAnimating()
        }
    }
    
    fileprivate func searchAnime(title: String?, completionHandler: (() -> Void)? = nil) {
        let request = AnnictAPI.GetWorks(filterTitle: title)
        AnnictAPIClient.send(request) { response in
            switch response {
            case .success(let value):
                self.popularAnimes = value.works
                completionHandler?()
            case .failure(let error):
                print(error)
                completionHandler?()
            }
        }
    }
}
