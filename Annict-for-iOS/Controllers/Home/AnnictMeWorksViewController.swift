//
//  AnnictMeWorksViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import XLPagerTabStrip

protocol AnnictMeWorksViewControllerDelegate {
    func didScroll(_ scrollView: UIScrollView)
}

enum TableViewState {
    case loading
    case idol
    case error
    case complete
}

// MARK: - AnnictMeWorksViewController

class AnnictMeWorksViewController: UITableViewController {
    
    struct Consts {
        static var contentInsetTop: CGFloat = 8.0
        static var contentInsetButton: CGFloat = 8.0
    }
    
    // 外部から指定
    var mode: AnimeStatus?
    var delegate: AnnictMeWorksViewControllerDelegate?
    
    fileprivate var works: [AnnictWorkResponse] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    fileprivate var state = TableViewState.idol
    fileprivate var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.initTableView()
        
        let indicator = self.initIndicatorView()
        self.getMeWorks() {
            indicator.stopAnimating()
        }
    }
    
    fileprivate func initTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let insets = UIEdgeInsets(top: Consts.contentInsetTop, left: 0, bottom: Consts.contentInsetButton, right: 0)
        self.tableView.contentInset = insets
        self.tableView.scrollIndicatorInsets = insets
        self.tableView.register(cellType: AnnictMeWorkCell.self)
        self.initRefreshControl()
    }
    
    fileprivate func initRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pulledTableView(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.annictPink.withAlphaComponent(0.7)
        self.refreshControl = refreshControl
    }
    
    fileprivate func initIndicatorView() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.center = CGPoint(x: view.bounds.midX, y: 24)
        indicator.color = .annictPink
        view.addSubview(indicator)
        indicator.startAnimating()
        return indicator
    }
    
    @objc func pulledTableView(_ refreshControl: UIRefreshControl) {
        self.currentPage = 0
        self.getMeWorks() {
            self.refreshControl?.endRefreshing()
        }
    }
    
    fileprivate func getMeWorks(completionHandler: (() -> Void)? = nil) {
        guard let filterStatus = mode else { return }
        let nextPage = self.currentPage+1
        self.state = .loading
        let request = AnnictAPI.GetMeWorks(page: nextPage, filterStatus: filterStatus)
        AnnictAPIClient.send(request) { response in
            switch response {
            case .success(let value):
                // 初回、pull更新時
                if self.currentPage == 0 {
                    self.works = value.works
                } else {
                    self.works += value.works
                }
                self.currentPage += 1
                self.state = .idol
                completionHandler?()
            case .failure(let error):
                print(error)
                self.state = .idol
                completionHandler?()
            }
        }
    }
}


extension AnnictMeWorksViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return works.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: AnnictMeWorkCell.self, for: indexPath)
        cell.set(work: works[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == works.count - 20 && self.state == .idol {
            self.getMeWorks()
        }
    }
}

extension AnnictMeWorksViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let annictDetailAnimeInfoVC = AnnictDetailAnimeInfoTabViewController.instantiate(withStoryboard: "AnnictWorks")
        annictDetailAnimeInfoVC.work = works[indexPath.row]
        annictDetailAnimeInfoVC.status = self.mode
        self.navigationController?.pushViewController(annictDetailAnimeInfoVC, animated: true)
    }
}

extension AnnictMeWorksViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.didScroll(scrollView)
    }
}

extension AnnictMeWorksViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: mode!.rawValue.localized(withTableName: "AnnictBaseLocalizable"))
    }
}
