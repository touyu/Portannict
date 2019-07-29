//
//  NibOwnerLoadable.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/01/16.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

public protocol NibOwnerLoadable {
    
}

public extension NibOwnerLoadable where Self: UIView {
    private var _viewID: String {
        return "loadedNibView"
    }
    
    var nibView: UIView? {
        return subviews.filter { $0.restorationIdentifier == _viewID }.first
    }
    
    func loadNib() {
        guard let view = UINib(nibName: self.className, bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("not load nib")
        }
        view.restorationIdentifier = _viewID
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        self.addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
