//
//  GradationView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/12/09.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

enum GradationType {
    case top, left, topLeft, bottomLeft, arctopLeft
    
    func points() ->  (start: CGPoint, end: CGPoint) {
        switch self {
        case .top:
            return (start: CGPoint(x: 0.5, y: 0), end: CGPoint(x: 0.5, y: 1))
        case .left:
            return (start: CGPoint(x: 0, y: 0.5), end: CGPoint(x: 1, y: 0.5))
        case .topLeft:
            return (start: CGPoint(x: 0, y: 0), end: CGPoint(x: 1, y: 1))
        case .bottomLeft:
            return (start: CGPoint(x: 0, y: 1), end: CGPoint(x: 1, y: 0))
        case .arctopLeft:
            return (start: CGPoint(x: 0, y: 0.3), end: CGPoint(x: 1, y: 0.7))
        }
    }
}

extension CALayer {
    func create(type: GradationType, colors: [UIColor]) -> CAGradientLayer {
        let gradationLayer = CAGradientLayer()
        
        gradationLayer.startPoint = type.points().start
        gradationLayer.endPoint = type.points().end
        
        gradationLayer.colors = colors.map { $0.cgColor }
        gradationLayer.frame = self.bounds
        return gradationLayer
    }
}
