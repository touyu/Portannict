//
//  TimelineViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/10/11.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class TimelineViewController: UITableViewController {
    fileprivate var activities: [FollowingActivity] = [] {
        didSet {
            if activities.count > 0 {
                tableView.isScrollEnabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "home".localized(withTableName: "AnnictBaseLocalizable")
        
        initTableView()
        getViewerFollowingActivities()
    }
    
    private func initTableView() {
        tableView.isScrollEnabled = false
        tableView.register(cellTypes: [TimelineShimmeringCell.self,
                                       TimelineCellForStatus.self,
                                       TimelineCellForRecord.self])
    }
    
    private func getViewerFollowingActivities() {
        AnnictGraphQLClient.request(query: GetViewerFollowingActivitiesQuery(after: "")) { [weak self] result, error in
            if let error = error {
                print(error)
                return
            }
            
            if let followingActivities = result?.data?.viewer?.followingActivities?.edges?.flatMap({ $0?.node }) {
                self?.activities += followingActivities
                self?.tableView.reloadData()
            }
        }
    }
}

extension TimelineViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count == 0 ? 3 : activities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if activities.count == 0 {
            return makeTimelineShimmeringCell(indexPath: indexPath)
        }
        
        let activity = activities[indexPath.row]
        guard let cellType = activity.cellType else {
            return makeTimelineShimmeringCell(indexPath: indexPath)
        }
        
        switch cellType {
        case .status:
            let cell = tableView.dequeueReusableCell(with: TimelineCellForStatus.self, for: indexPath)
            cell.set(activity: activity.asStatus)
            return cell
        case .record:
            let cell = tableView.dequeueReusableCell(with: TimelineCellForRecord.self, for: indexPath)
            cell.set(activity: activity.asRecord)
            return cell
        default:
           return makeTimelineShimmeringCell(indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.contentOffset.y == 0 {
            cell.alpha = 0.2
            UIView.animate(withDuration: 0.4, delay: 0, options: .allowUserInteraction, animations: {
                cell.alpha = 1
            }, completion: nil)

        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func makeTimelineShimmeringCell(indexPath: IndexPath) -> TimelineShimmeringCell {
        return tableView.dequeueReusableCell(with: TimelineShimmeringCell.self, for: indexPath)
    }
}
