//
//  SettingTableViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/03/20.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit
import SafariServices

class SettingTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "setting".localized(withTableName: "AnnictBaseLocalizable")
    }
    
    @IBAction func tappedCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            openTermsOfService()
        default:
            break
        }
    }
    
    fileprivate func openTermsOfService() {
        guard let url = URL(string: "https://touyu.github.io/Annict-for-iOS-Website/rule/") else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}
