//
//  CircleLoadingView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/06/28.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

@IBDesignable
class CircleLoadingView: UIView {
    
    private var ovalView1 = UIView()
    private var ovalView2 = UIView()
    private var ovalView3 = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        for ovalView in [ovalView1, ovalView2, ovalView3] {
            addSubview(ovalView)
            ovalView.backgroundColor = .annictPink
            ovalView.layer.masksToBounds = true
            ovalView.layer.cornerRadius = 4
            ovalView.translatesAutoresizingMaskIntoConstraints = false
            ovalView.widthAnchor.constraint(equalToConstant: 8).isActive = true
            ovalView.heightAnchor.constraint(equalToConstant: 8).isActive = true
            ovalView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
        
        ovalView2.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        ovalView1.trailingAnchor.constraint(equalTo: ovalView2.leadingAnchor, constant: -6).isActive = true
        ovalView3.leadingAnchor.constraint(equalTo: ovalView2.trailingAnchor, constant: 6).isActive = true
        
        startAnimation()
    }
    
    func startAnimation() {
        let duration: CFTimeInterval = 0.8
        let beginTime = CACurrentMediaTime()
        let beginTimes = [0, 0.2, 0.4]
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.keyTimes = [0, 0.4, 1]
        opacityAnimation.values = [1, 0.2, 1]
        opacityAnimation.duration = duration
        
        let animation = CAAnimationGroup()
        animation.animations = [opacityAnimation]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        for (i, ovalView) in [ovalView1, ovalView2, ovalView3].enumerated() {
            animation.beginTime = beginTime + beginTimes[i]
            ovalView.layer.add(animation, forKey: "animation")
        }
    }
}
