//
//  AnnictSelectStatusViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class AnnictSelectStatusViewController: UIViewController {
    
    // 外部から指定
    var changeAnimeStatus: ((_ newAnimeStatus: AnimeStatus) -> Void)?
    var defaultStatus: AnimeStatus! {
        didSet {
            self.selectedItem = self.defaultStatus
        }
    }
    
    @IBOutlet dynamic fileprivate weak var tableView: UITableView!
    
    fileprivate var statusList = AnimeStatus.getList()
    fileprivate var selectedItem: AnimeStatus!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // NavigationBar下線復活
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // NavigationBar下線削除
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    fileprivate func initTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
    }
}

extension AnnictSelectStatusViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "defaultCell")
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textColor = UIColor(hex: 0x1E1E1E)
        cell.textLabel?.text = statusList[indexPath.row].localizedString
        cell.selectionStyle = .none
        cell.tintColor = .annictPink
        if statusList[indexPath.row] == self.selectedItem {
            cell.accessoryType = .checkmark
        }
        return cell
    }
}

extension AnnictSelectStatusViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        // 初期化時のチェックマークを消す
        if self.selectedItem == self.defaultStatus {
            let index = self.statusList.index(of: selectedItem)!
            let indexPath = IndexPath(row: index, section: 0)
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
        }
        
        self.selectedItem = statusList[indexPath.row]
        
        // チェックマークを入れる
        cell?.accessoryType = .checkmark
        
        if self.defaultStatus != selectedItem {
            self.changeAnimeStatus?(selectedItem)
        }
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        // チェックマークを外す
        cell?.accessoryType = .none
    }
}
