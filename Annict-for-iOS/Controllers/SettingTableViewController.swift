//
//  SettingTableViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/03/20.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "setting".localized(withTableName: "AnnictBaseLocalizable")
    }
    
    @IBAction func tappedCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
