//
//  AnnictSeasonViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/15.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import XLPagerTabStrip


// MARK: - AnnictSeasonViewController

class AnnictSeasonViewController: UITableViewController {
    
    var season: Season!
    var year: Int!
    
    fileprivate var currentPage = 0
    fileprivate var state = TableViewState.idol
    
    fileprivate var animes: [AnnictWorkResponse] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTableView()
        self.initRefreshControl()
        self.startRefreshControlAnimation()
        self.getAnimes() { [weak self] _ in
            if self?.state != .error {
                self?.refreshControl?.endRefreshing()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initReachability()
    }
    
    fileprivate func initTableView() {
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset.top = 8
        self.tableView.register(cellType: AnnictMeWorkCell.self)
    }
    
    fileprivate func getAnimes(completionHandler: (() -> Void)? = nil) {
        let nextPage = self.currentPage+1
        self.state = .loading
        let request = AnnictAPI.GetWorks(page: nextPage, filterSeason: (year: year, season: season))
        AnnictAPIClient.send(request) { response in
            switch response {
            case .success(let value):
                // 初回、pull更新時
                if self.currentPage == 0 {
                    self.animes = value.works
                } else {
                    self.animes += value.works
                }
                self.currentPage += 1
                if value.works.isEmpty {
                    self.state = .complete
                } else {
                    self.state = .idol
                }
                completionHandler?()
            case .failure(let error):
                print(error)
                self.state = .error
                completionHandler?()
            }
        }
    }
    
    fileprivate func initRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pulledTableView(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.annictPink.withAlphaComponent(0.7)
        self.refreshControl = refreshControl
    }
    
    private func startRefreshControlAnimation() {
        tableView.contentOffset.y = -self.refreshControl!.bounds.height
        self.refreshControl?.beginRefreshing()
    }
    
    func pulledTableView(_ refreshControl: UIRefreshControl) {
        self.currentPage = 0
        self.getAnimes() { [weak self] _ in
            if self?.state != .error {
                self?.refreshControl?.endRefreshing()
            }
        }
    }
    
    private func initReachability() {
        ReachabilityHelper.observe(whenReachable: { [weak self] _ in
            if self?.state == .error {
                self?.getAnimes() { [weak self] _ in
                    if self?.state != .error {
                        self?.refreshControl?.endRefreshing()
                    }
                }
            }
            }, whenUnreachable: nil)
    }
}

extension AnnictSeasonViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: AnnictMeWorkCell.self, for: indexPath)
        cell.set(work: animes[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == animes.count - 20 && self.state == .idol {
            self.getAnimes()
        }
    }
}

extension AnnictSeasonViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let annictDetailAnimeInfoVC = AnnictDetailAnimeInfoTabViewController.instantiate(withStoryboard: "AnnictWorks")
        annictDetailAnimeInfoVC.work = animes[indexPath.row]
        self.navigationController?.pushViewController(annictDetailAnimeInfoVC, animated: true)
    }
}

extension AnnictSeasonViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: season.rawValue.localized(withTableName: "AnnictBaseLocalizable"))
    }
}
