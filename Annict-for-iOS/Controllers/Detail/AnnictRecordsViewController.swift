//
//  AnnictRecordsViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import XLPagerTabStrip
import DZNEmptyDataSet


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
    
    fileprivate var state = TableViewState.idol {
        didSet {
            tableView.reloadEmptyDataSet()
        }
    }
    fileprivate var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        startRefreshControlAnimation()
        getRecords() { [weak self] _ in
            self?.refreshControl?.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initReachability()
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
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        self.initRefreshControl()
    }
    
    fileprivate func initRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pulledTableView(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.annictPink.withAlphaComponent(0.7)
        self.refreshControl = refreshControl
    }
    
    fileprivate func startRefreshControlAnimation() {
        tableView.contentOffset.y = -self.refreshControl!.bounds.height
        self.refreshControl?.beginRefreshing()
    }
    
    func pulledTableView(_ refreshControl: UIRefreshControl) {
        self.currentPage = 0
        self.getRecords() { [weak self] _ in
            self?.refreshControl?.endRefreshing()
        }
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
                self?.state = .error
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
    
    private func initReachability() {
        ReachabilityHelper.observe(whenReachable: { [weak self] _ in
            if self?.state == .error {
                self?.getRecords()
            }
            }, whenUnreachable: nil)
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
        if let record = cell.record, record.user?.id == AnnictConsts.userID {
            self.showActionSheet(recordID: record.id, indexPath: indexPath)
        } else {
            self.showReportActionSheet()
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
    
    fileprivate func showReportActionSheet() {
        let actionSheet = UIAlertController(title: "", message: "選択してください", preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "この記録を通報する", style: .destructive, handler: nil)
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        actionSheet.addAction(delete)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
}

extension AnnictRecordsViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: mode.rawValue)
    }
}

extension AnnictRecordsViewController: DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        switch state {
        case .error:
            return DZNEmptyDataSetHelper.NetworkError.title
        case .complete:
            return DZNEmptyDataSetHelper.Empty.title
        default:
            return NSAttributedString()
        }
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        switch self.state {
        case .error:
            return DZNEmptyDataSetHelper.NetworkError.buttonTitle
        case .complete:
            return nil
        default:
            return NSAttributedString()
        }
    }
    
    func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> UIImage! {
        return DZNEmptyDataSetHelper.NetworkError.buttonBackgroundImage(view: view, state: state)
    }
}

extension AnnictRecordsViewController: DZNEmptyDataSetDelegate {
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        startRefreshControlAnimation()
        getRecords() { [weak self] _ in
            self?.refreshControl?.endRefreshing()
        }
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        switch state {
        case .error, .complete:
            return true
        default:
            return false
        }
    }
}
