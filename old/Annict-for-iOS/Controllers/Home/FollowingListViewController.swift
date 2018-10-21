//
//  FollowingListViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/06/12.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class FollowingListViewController: UIViewController {
    
    @IBOutlet dynamic private weak var tableView: UITableView!
    
    fileprivate var following: [GetViewerFollowingQuery.Data.Viewer.Following.Edge.Node] = []
    
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
        tableView.register(cellTypes: [FollowingUserCell.self])
        tableView.tableFooterView = CircleLoadingView(frame: CGRect(0, 0, view.bounds.width, 40))
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        navigationItem.title = "following".localized(withTableName: "AnnictBaseLocalizable")
        getFollowing()
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
    
    fileprivate func getFollowing() {
        requestedEndCursor = endCursor
        AnnictGraphQLClient.request(query: GetViewerFollowingQuery(after: endCursor)) { [weak self] result, error in
            if let error = error {
                print(error)
                return
            }
            
            if let endCursor = result?.data?.viewer?.following?.pageInfo.endCursor {
                self?.endCursor = endCursor
            }
            
            if let hasNextPage = result?.data?.viewer?.following?.pageInfo.hasNextPage {
                self?.hasNextPage = hasNextPage
            }
            
            guard let edges = result?.data?.viewer?.following?.edges else { return }
            let following = edges.flatMap { $0?.node }
            self?.following += following
            self?.tableView.reloadData()
        }
    }
}

extension FollowingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return following.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: FollowingUserCell.self, for: indexPath)
        cell.set(user: following[indexPath.row])
        return cell
    }
}

extension FollowingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == following.count-1 && requestedEndCursor != endCursor {
            if hasNextPage {
                getFollowing()
            }
        }
    }
}
