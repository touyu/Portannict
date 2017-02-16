//
//  AnnictRecordsViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import XLPagerTabStrip


// MARK: - AnnictRecordsViewController

class AnnictRecordsViewController: UITableViewController {
    
    enum RecordsMode: String {
        case all = "全感想"
        case comment = "コメント有り"
    }
    
    // 外部から指定
    var episodeID: Int!
    
    var mode: RecordsMode = .all
    
    fileprivate var records: [AnnictRecordResponse] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate var state = TableViewState.idol
    fileprivate var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTableView()
        let indicotor = self.initIndicatorView()
        self.getRecords() { _ in
            indicotor.stopAnimating()
        }
    }
    
    func refreshTableView() {
        self.currentPage = 0
        self.getRecords()
    }
    
    fileprivate func initTableView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(cellType: AnnictRecordCell.self)
        self.initRefreshControl()
    }
    
    fileprivate func initRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pulledTableView(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.annictPink.withAlphaComponent(0.7)
        self.refreshControl = refreshControl
    }
    
    func pulledTableView(_ refreshControl: UIRefreshControl) {
        self.currentPage = 0
        self.getRecords() { _ in
            self.refreshControl?.endRefreshing()
        }
    }
    
    fileprivate func initIndicatorView() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.center = CGPoint(x: view.bounds.midX, y: 24)
        indicator.color = .annictPink
        view.addSubview(indicator)
        indicator.startAnimating()
        return indicator
    }
    
    fileprivate func getRecords(completionHandler: (() -> Void)? = nil) {
        let nextPage = self.currentPage+1
        self.state = .loading
        let request = AnnictAPI.GetRecords(episodeID: episodeID, page: nextPage)
        AnnictAPIClient.send(request) {[weak self] response in
            switch response {
            case .success(let value):
                if value.records.isEmpty {
                    self?.state = .complete
                } else {
                    self?.setRecords(records: value.records)
                    self?.currentPage += 1
                    self?.state = .idol
                }
                completionHandler?()
            case .failure(let error):
                print(error)
                self?.state = .idol
                completionHandler?()
            }
        }
    }
    
    fileprivate func setRecords(records: [AnnictRecordResponse]) {
        // 全感想モード
        if self.mode == .all {
            if self.currentPage == 0 {
                self.records = records
            } else {
                self.records += records
            }
        } else { // コメント有りモード
            if self.currentPage == 0 {
                self.records = records.filter {
                    if let comment = $0.comment, !(comment.isEmpty) {
                        return true
                    } else {
                        return false
                    }
                }
            } else {
                self.records += records.filter {
                    if let comment = $0.comment, !(comment.isEmpty) {
                        return true
                    } else {
                        return false
                    }
                }
            }
        }
    }
}

extension AnnictRecordsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: AnnictRecordCell.self, for: indexPath)
        cell.set(record: records[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var pagingPoint = records.count - 20
        if pagingPoint - 20 < 0 {
            pagingPoint = records.count - 1
        }

        if indexPath.row == pagingPoint && self.state == .idol {
            self.getRecords()
        }
    }
}

extension AnnictRecordsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? AnnictRecordCell else { return }
        if let record = cell.record, record.user.id == AnnictConsts.userID {
            self.showActionSheet(recordID: record.id, indexPath: indexPath)
        }
    }
    
    fileprivate func showActionSheet(recordID: Int, indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: "", message: "選択してください", preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "記録を削除", style: .destructive, handler: { _ in
            self.records.remove(at: indexPath.row)
            self.tableView.reloadData()
            self.deleteMeRecord(recordID: recordID) { _ in
                self.refreshTableView()
            }
        })
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        actionSheet.addAction(delete)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    
    fileprivate func deleteMeRecord(recordID: Int, completionHandler: (() -> Void)? = nil ) {
        let request = AnnictAPI.DeleteMeRecord(id: recordID)
        AnnictAPIClient.send(request) { response in
            switch response {
            case .success:
                completionHandler?()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension AnnictRecordsViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: mode.rawValue)
    }
}
