//
//  UITableView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/14.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

extension UITableView {
    func register(_ cellTypes: UITableViewCell.Type...) {
        cellTypes.forEach {
            let nib = UINib(nibName: $0.className, bundle: nil)
            register(nib, forCellReuseIdentifier: $0.className)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(classType type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}
