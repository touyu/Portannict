//
//  TimelineViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/10/11.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class TimelineViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isScrollEnabled = false
        tableView.register(cellType: TimelineShimmeringCell.self)
    }
}

extension TimelineViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: TimelineShimmeringCell.self, for: indexPath)
        return cell
    }
}
