//
//  AnnictEpisodeViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/12.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import XLPagerTabStrip


// MARK: - AnnictEpisodeViewController

class AnnictEpisodeViewController: UIViewController {
    
    // 外部から指定
    var workID: Int!
    
    @IBOutlet dynamic fileprivate weak var tableView: UITableView!
    
    fileprivate var episodes: [AnnictEpisodeResponse] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTableView()
        
        let request = AnnictAPI.GetEpisodes(workID: workID)
        AnnictAPIClient.send(request) { response in
            switch response {
            case .success(let value):
                self.episodes = value.episodes
            case .failure(let error):
                print(error)
            }
        }
    }
    
    fileprivate func initTableView() {
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(cellType: AnnictEpisodeCell.self)
    }
}

extension AnnictEpisodeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: AnnictEpisodeCell.self, for: indexPath)
        cell.set(episode: episodes[indexPath.row])
        return cell
    }
}

extension AnnictEpisodeViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "エピソード")
    }
}
