//
//  ShimmerableView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/10/14.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class ShimmerableView: UIView {
    var isShimmering: Bool = true {
        didSet {
            if isShimmering {
                gradientLayer.startAnimation()
            } else {
                gradientLayer.stopAnimation()
            }
        }
    }
    
    private var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initGradientlayer()
        gradientLayer.startAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initGradientlayer()
        gradientLayer.startAnimation()
    }
    
    private func initGradientlayer() {
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let colors = [UIColor.white.brighten(by: 0.92).cgColor,
                      UIColor.white.brighten(by: 0.88).cgColor,
                      UIColor.white.brighten(by: 0.92).cgColor]
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 0.5, 1.0]
    }
}

private extension CAGradientLayer {
    func startAnimation() {
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        //        gradientAnimation.fromValue = [-1.0, -0.5, 0]
        //        gradientAnimation.toValue = [1, 1.5, 2.0]
        gradientAnimation.fromValue = [-2.0, -1.0, 0]
        gradientAnimation.toValue = [1, 2.0, 3.0]
        gradientAnimation.duration = 1.0
        gradientAnimation.repeatCount = Float.infinity
        gradientAnimation.isRemovedOnCompletion = false
        gradientAnimation.fillMode = kCAFillModeForwards
        add(gradientAnimation, forKey: nil)
    }
    
    func stopAnimation() {
        removeAllAnimations()
    }
}

private extension UIColor {
    func brighten(by ratio: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: saturation, brightness: brightness * ratio, alpha: alpha)
        }
        return self
    }
}
