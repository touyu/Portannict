//
//  AnnictDetailAnimeInfoViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/12.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit
import SafariServices

import XLPagerTabStrip


// MARK: - AnnictDetailAnimeInfoViewController

class AnnictDetailAnimeInfoViewController: UIViewController {
    
    // 外部から指定
    var work: AnnictWorkResponse!
    var status: AnimeStatus? {
        didSet {
            if self.tableView != nil {
                self.initDataSource()
            }
        }
    }
    
    @IBOutlet dynamic fileprivate weak var tableView: UITableView!
    
    fileprivate var dataSources:[(title: String, subtext: String)] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    enum BasicInfo {
        case status
        case media
        case release
        case account
        case hashtag
        case officialSite
        case wikipedia
    }
    
    fileprivate var memoTags:[BasicInfo] = []
    
    enum AcquisitionOfStatus {
        case getting
        case updating
        case completion
    }
    
    fileprivate var acquisition: AcquisitionOfStatus = .completion
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initDataSource()
        self.initTableView()
    }
    
    fileprivate func initTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(cellType: AnnictSubtextCell.self)
    }
    
    fileprivate func initDataSource() {
        var dataSources: [(title: String, subtext: String)] = []
        
        if let status = self.status {
            dataSources.append((title: "ステータス", subtext: status.localizedString))
            memoTags.append(.status)
            self.acquisition = .completion
        } else {
            dataSources.append((title: "ステータス", subtext: "取得中..."))
            memoTags.append(.status)
            self.acquisition = .getting
            self.getAnimeStatus()
        }
        dataSources.append((title: "メディア", subtext: work.mediaText))
        memoTags.append(.media)
        if let seasonNameText = work.seasonNameText {
            dataSources.append((title: "リリース時期", subtext: seasonNameText))
            memoTags.append(.release)
        }
        if let twiterUsername = work.twitterUserName, !(twiterUsername.isEmpty) {
            dataSources.append((title: "Twitterアカウント", subtext: "@\(twiterUsername)"))
            memoTags.append(.account)
        }
        if let hashTag = work.twitterHashTag, !(hashTag.isEmpty) {
            dataSources.append((title: "Twitterハッシュタグ", subtext: "#\(hashTag)"))
            memoTags.append(.hashtag)
        }
        if let officialSiteURL = work.officialSiteURL, !(officialSiteURL.isEmpty) {
            dataSources.append((title: "公式サイト", subtext: ""))
            memoTags.append(.officialSite)
        }
        if let wikipediaURL = work.wikipediaURL, !(wikipediaURL.isEmpty) {
            dataSources.append((title: "Wikipedia", subtext: ""))
            memoTags.append(.wikipedia)
        }
        
        self.dataSources = dataSources
    }
    
    fileprivate func updateMeStatuses(newStatus: AnimeStatus, completionHandler: ((_ status: AnimeStatus?) -> Void)?) {
        let request = AnnictAPI.PostStatuses(workID: work.id, kind: newStatus)
        AnnictAPIClient.send(request) { response in
            switch response {
            case .success():
                completionHandler?(newStatus)
            case .failure(let error):
                print(error)
                completionHandler?(nil)
            }
        }
    }
    
    fileprivate func getAnimeStatus() {
        let request = AnnictAPI.GetMeWorks(id: work.id)
        AnnictAPIClient.send(request) { [weak self] response in
            switch response {
            case .success(let value):
                self?.status = value.works.first?.status
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension AnnictDetailAnimeInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: AnnictSubtextCell.self.self, for: indexPath)
        cell.set(information: dataSources[indexPath.row])
        return cell
    }
}


extension AnnictDetailAnimeInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch memoTags[indexPath.row] {
        case .status:
            // ステータスの取得状況がcompletion以外のときは選択できないようにする
            if self.acquisition != .completion {
                return
            }
            
            let annictSelectStatusViewController = AnnictSelectStatusViewController.instantiate(withStoryboard: "AnnictWorks")
            annictSelectStatusViewController.defaultStatus = status ?? .noSelect
            annictSelectStatusViewController.changeAnimeStatus = { newStatus in
                // 更新中と表示させる
                let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AnnictSubtextCell
                cell?.set(information: (title: "ステータス", subtext: "更新中..."))
                self.acquisition = .updating
                
                // 結果を表示させる
                self.updateMeStatuses(newStatus: newStatus) { status in
                    self.acquisition = .completion
                    if let newStatus = status {
                        self.status = newStatus
                    } else {
                        self.tableView.reloadData()
                    }
                }
            }
            self.navigationController?.pushViewController(annictSelectStatusViewController, animated: true)
        case .account:
            guard let account = work.twitterUserName else { return }
            let url = "https://twitter.com/\(account)"
            self.openSFSafariViewController(url: url)
        case .hashtag:
            guard let hashTag = work.twitterHashTag else { return }
            let url = "https://twitter.com/hashtag/\(hashTag)?src=hash"
            self.openSFSafariViewController(url: url)
        case .officialSite:
            guard let url = work.officialSiteURL else { return }
            self.openSFSafariViewController(url: url)
        case .wikipedia:
            guard let url = work.wikipediaURL else { return }
            self.openSFSafariViewController(url: url)
        default:
            break
        }
    }
    
    fileprivate func openSFSafariViewController(url: String) {
        guard let url = URL(string: url) else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}


extension AnnictDetailAnimeInfoViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "詳細")
    }
}
