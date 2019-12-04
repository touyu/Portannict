//
//  Icon.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/12/04.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

//enum IconImage {
//    case paperAirplane
//
//    var image: UIImage? {
//        let result: UIImage?
//        switch self {
//        case .paperAirplane:
//            result = UIImage(named: "paperplane_fill")
//        }
//        return result?.withRenderingMode(.alwaysTemplate)
//    }
//}
//
//extension UIButton {
//    func configure(icon: IconImage, for state: UIControl.State = .normal) {
//        setImage(icon.image, for: state)
//    }
//}

enum IconImage: String {
    case pencil = "pencil"
    case calendar = "calendar"
    case paperAirplane = "paperplane_fill"

    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}

extension UIButton {

    convenience init(icon: IconImage) {
        self.init(type: .custom)
        setImage(icon.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        imageView?.contentMode = .scaleAspectFit
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        backgroundColor = .white
        imageEdgeInsets = UIEdgeInsets(top: -8, left: -8, bottom: -8, right: -8)
    }

    func configure(icon: IconImage, size: CGFloat = 10, color: UIColor = .white, for state: UIControl.State = .normal) {
        setImage(icon.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        imageView?.contentMode = .scaleAspectFit
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        let inset = (bounds.width - size) / 2
        imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        tintColor = color
    }

    func applyFABShadow() {
        applyShadow(opacity: 0.4, radius: 4, offset: CGSize(width: 0, height: 3))
    }
}
