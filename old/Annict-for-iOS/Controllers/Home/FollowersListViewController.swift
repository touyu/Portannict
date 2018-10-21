//
//  FollowersListViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/06/15.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class FollowersListViewController: UIViewController {
    
    @IBOutlet dynamic private weak var tableView: UITableView!
    
    fileprivate var followers: [GetViewerFollowersQuery.Data.Viewer.Follower.Edge.Node] = []
    
    fileprivate var endCursor = ""
    fileprivate var hasNextPage = true {
        didSet {
            if hasNextPage == false {
                tableView.tableFooterView = UIView()
            }
        }
    }
    fileprivate var requestedEndCursor = "requestedEndCursor"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: FollowerUserCell.self)
        tableView.tableFooterView = CircleLoadingView(frame: CGRect(0, 0, view.bounds.width, 40))
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        navigationItem.title = "follower".localized(withTableName: "AnnictBaseLocalizable")
        getFollowers()
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
    
    fileprivate func getFollowers() {
        requestedEndCursor = endCursor
        AnnictGraphQLClient.request(query: GetViewerFollowersQuery(after: endCursor)) { [weak self] result, error in
            if let error = error {
                print(error)
                return
            }
            
            if let endCursor = result?.data?.viewer?.followers?.pageInfo.endCursor {
                self?.endCursor = endCursor
            }
            
            if let hasNextPage = result?.data?.viewer?.followers?.pageInfo.hasNextPage {
                self?.hasNextPage = hasNextPage
            }
            
            guard let edges = result?.data?.viewer?.followers?.edges else { return }
            let followers = edges.flatMap { $0?.node }
            self?.followers += followers
            self?.tableView.reloadData()
        }
    }
}

extension FollowersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: FollowerUserCell.self, for: indexPath)
        cell.set(user: followers[indexPath.row])
        return cell
    }
}

extension FollowersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == followers.count-1 && requestedEndCursor != endCursor {
            if hasNextPage {
                getFollowers()
            }
        }
    }
}
