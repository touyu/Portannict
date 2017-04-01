//
//  ActivitiesViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/04/01.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController {
    
    @IBOutlet dynamic fileprivate weak var tableView: UITableView!
    
    fileprivate var activities: [AnnictActivityResponse] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "home".localized(withTableName: "AnnictBaseLocalizable")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 240
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(cellTypes: [AnnictActivityCreateStatusCell.self,
                                       AnnictActivityCreateRecordCell.self,
                                       AnnictActivityCreateMultipleRecordsCell.self])
        
        getMeFollowingActivities()
    }
    
    fileprivate func getMeFollowingActivities() {
        let request = AnnictAPI.GetMeFollowingActivities()
        AnnictAPIClient.send(request) { [weak self] response in
            switch response {
            case .success(let value):
                self?.activities = value.activities
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ActivitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getActivityCell(activity: activities[indexPath.row], indexPath: indexPath)
    }
    
    fileprivate func getActivityCell(activity: AnnictActivityResponse, indexPath: IndexPath) -> UITableViewCell {
        guard let action = activity.action else { return UITableViewCell() }
        
        switch action {
        case .createRecord:
            let cell = tableView.dequeueReusableCell(with: AnnictActivityCreateRecordCell.self, for: indexPath)
            cell.set(activity: activity)
            return cell
        case .createMultipleRecords:
            let cell = tableView.dequeueReusableCell(with: AnnictActivityCreateMultipleRecordsCell.self, for: indexPath)
            cell.set(activity: activity)
            return cell
        case .createStatus:
            let cell = tableView.dequeueReusableCell(with: AnnictActivityCreateStatusCell.self, for: indexPath)
            cell.set(activity: activity)
            return cell
        }
    }
}

extension ActivitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
