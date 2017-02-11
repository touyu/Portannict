//
//  HomeViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit


// MARK: - HomeViewController

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = AnnictAPI.GetMeWorks(filterStatus: .watching)
        AnnictAPI.send(request) { response in
            switch response {
            case .success(let value):
                for work in value.works {
                    print(work.title)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
