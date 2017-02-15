//
//  YearPickerView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/15.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

protocol YearPickerViewDelegate {
    func didSelectYear(year: Int)
}

class YearPickerView: UIView {
    
    var delegate: YearPickerViewDelegate?
    
    var defaultYear: Int! {
        didSet {
            self.pickerView.selectRow(2020-defaultYear, inComponent: 0, animated: false)
        }
    }
    
    @IBOutlet dynamic fileprivate weak var pickerView: UIPickerView!
    
    fileprivate var years: [Int] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup(self.frame)
    }
    
    fileprivate func setup(_ frame: CGRect) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: YearPickerView.self), bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            self.addSubview(view)
            
            // カスタムViewのサイズを自分自身と同じサイズにする
            view.translatesAutoresizingMaskIntoConstraints = false
            let bindings = ["view": view]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                          options:NSLayoutFormatOptions(rawValue: 0),
                                                          metrics:nil,
                                                          views: bindings))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                          options:NSLayoutFormatOptions(rawValue: 0),
                                                          metrics:nil,
                                                          views: bindings))
        }
        self.initPickerView()
    }
    
    fileprivate func initPickerView() {
        for i in 1960...2020 {
            years.insert(i, at: 0)
        }
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
    }
}

extension YearPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(years[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.delegate?.didSelectYear(year: years[row])
    }
}
