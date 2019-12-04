//
//  Icon.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/12/04.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

enum IconImage {
    case paperAirplane

    var image: UIImage? {
        let result: UIImage?
        switch self {
        case .paperAirplane:
            result = UIImage(named: "paperplane_fill")
        }
        return result?.withRenderingMode(.alwaysTemplate)
    }
}

extension UIButton {
    func configure(icon: IconImage, for state: UIControl.State = .normal) {
        setImage(icon.image, for: state)
    }
}
