//
//  AnnictMeWorksViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit


// MARK: - AnnictMeWorksViewController

class AnnictMeWorksViewController: UIViewController {
    
    @IBOutlet dynamic private weak var tableView: UITableView!
    
    fileprivate var works: [AnnictWorkResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getMeWorks()
        self.initTableView()
    }
    
    fileprivate func initTableView() {
        self.tableView.dataSource = self
        self.tableView.contentInset.top = 8
        self.tableView.register(cellType: AnnictMeWorkCell.self)
    }
    
    fileprivate func getMeWorks() {
        let request = AnnictAPI.GetMeWorks(filterStatus: .watching)
        AnnictAPIClient.send(request) { response in
            switch response {
            case .success(let value):
                self.works = value.works
                for work in value.works {
                    print(work.title)
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension AnnictMeWorksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return works.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: AnnictMeWorkCell.self, for: indexPath)
        cell.set(work: works[indexPath.row])
        return cell
    }
}
