//
//  UICollectionView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/14.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UITableViewCell>(cellTypes: T.Type...) {
        cellTypes.forEach {
            let nib = UINib(nibName: $0.className, bundle: nil)
            register(nib, forCellWithReuseIdentifier: $0.className)
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
}
