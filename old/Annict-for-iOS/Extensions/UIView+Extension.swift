//
//  UIView+Extension.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/15.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

protocol NibInstantiatable {}
extension UIView: NibInstantiatable {}

extension NibInstantiatable where Self: UIView {
    static func instantiate(withOwner ownerOrNil: Any? = nil) -> Self {
        let nib = UINib(nibName: String(describing: self), bundle: nil)
        return nib.instantiate(withOwner: ownerOrNil, options: nil)[0] as! Self
    }
}
