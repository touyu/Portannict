//
//  RadioButton.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/12/04.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class RadioButton: UIControl {
    var color: UIColor = UIColor(hex: 0x3498DB) {
        didSet {
            updateColor()
        }
    }

    var isOn: Bool = false {
        didSet {
            Taptic.run(.impact(.medium))
            checkView.isHidden = !isOn
            sendActions(for: .valueChanged)
        }
    }

    let checkView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        layer.borderWidth = 1.5
        checkView.isHidden = !isOn
        addSubview(checkView)
        checkView.snp.makeConstraints {
            $0.edges.equalTo(snp.edges).inset(4)
        }
        updateColor()

        let gesture = UITapGestureRecognizer { [weak self] sender in
            self?.isOn.toggle()
        }
        addGestureRecognizer(gesture)
    }

    func updateColor() {
        layer.borderColor = color.cgColor
        checkView.backgroundColor = color
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        checkView.layer.cornerRadius = checkView.bounds.width / 2
        checkView.layer.masksToBounds = true
        layer.cornerRadius = bounds.width / 2
        layer.masksToBounds = true
    }
}

extension Reactive where Base: RadioButton {
    var isOn: ControlProperty<Bool> {
        return value
    }
    
    private var value: ControlProperty<Bool> {
        return UIControl.valuePublic(base,
        getter: { control in
            control.isOn
        }, setter: { control, value in
            control.isOn = value
        })
    }
}

extension UIControl {
    static func valuePublic<T, ControlType: UIControl>(_ control: ControlType, getter:  @escaping (ControlType) -> T, setter: @escaping (ControlType, T) -> ()) -> ControlProperty<T> {
        let values: Observable<T> = Observable.deferred { [weak control] in
            guard let existingSelf = control else {
                return Observable.empty()
            }

            return (existingSelf as UIControl).rx.controlEvent([.allEditingEvents, .valueChanged])
                .flatMap { _ in
                    return control.map { Observable.just(getter($0)) } ?? Observable.empty()
            }
            .startWith(getter(existingSelf))
        }
        return ControlProperty(values: values, valueSink: Binder(control) { control, value in
            setter(control, value)
        })
    }
}
