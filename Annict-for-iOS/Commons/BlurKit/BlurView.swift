//
//  BlurKit.swift
//  BlurKit
//
//  Created by Yuto Akiba on 2018/10/05.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

open class BlurView: UIVisualEffectView {

    private let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()

    open var colorTint: UIColor? {
        get { return _value(forKey: "colorTint") as? UIColor }
        set { _setValue(newValue, forKey: "colorTint") }
    }

    open var colorTintAlpha: CGFloat {
        get { return _value(forKey: "colorTintAlpha") as! CGFloat }
        set { _setValue(newValue, forKey: "colorTintAlpha") }
    }

    open var blurRadius: CGFloat {
        get { return _value(forKey: "blurRadius") as! CGFloat }
        set { _setValue(newValue, forKey: "blurRadius") }
    }

    open var scale: CGFloat {
        get { return _value(forKey: "scale") as! CGFloat }
        set { _setValue(newValue, forKey: "scale") }
    }

    public override init(effect: UIVisualEffect?) {
        super.init(effect: effect)

        prepare()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        prepare()
    }

    private func prepare() {
        scale = 1
    }

    private func _value(forKey key: String) -> Any? {
        return blurEffect.value(forKeyPath: key)
    }

    private func _setValue(_ value: Any?, forKey key: String) {
        blurEffect.setValue(value, forKeyPath: key)
        effect = blurEffect
    }

}

