//
//  AnnictSeasonTabViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/15.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import XLPagerTabStrip


// MARK: - AnnictMeWorksTabViewController

class AnnictSeasonTabViewController: ButtonBarPagerTabStripViewController {
    
    fileprivate var year: Int! {
        didSet {
            if isOpendPickerView {
                self.initNavigationTitle(title: String(year) + " ▲")
            } else {
                self.initNavigationTitle(title: String(year) + " ▼")
            }
        }
    }
    
    fileprivate var season: Season!
    
    fileprivate var yearPickerView: YearPickerView!
    fileprivate var isOpendPickerView: Bool = false
    
    override func viewDidLoad() {
        // set up style before super view did load is executed
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemFont = .systemFont(ofSize: 16, weight: UIFontWeightThin)
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.selectedBarBackgroundColor = UIColor.annictPink
        settings.style.selectedBarHeight = 2.0
        //-
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = UIColor(hex: 0x1E1E1E, alpha: 0.6)
            newCell?.label.textColor = UIColor.annictPink
            
            if animated {
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
            }
            else {
                newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
        
        self.year = self.getCurrentYear()
        self.season = Season.current
        
        super.viewDidLoad()
        
        // 画面サイズによってtabのサイズが揃うようにする
        // self.buttonBarView.layoutIfNeeded()
        
        containerView.backgroundColor = UIColor(hex: 0xF2F2F2)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.initNavigationTitle(title: String(year) + " ▼")
        self.yearPickerView = YearPickerView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.bounds.width, height: 240)))
        self.yearPickerView.frame.origin.y = -self.yearPickerView.bounds.height
        self.yearPickerView.delegate = self
        moveToViewController(at: season.number)
    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let a = AnnictSeasonViewController.instantiate(withStoryboard: "AnnictMeWorks")
        a.season = .spring
        a.year = self.year
        let b = AnnictSeasonViewController.instantiate(withStoryboard: "AnnictMeWorks")
        b.season = .summer
        b.year = self.year
        let c = AnnictSeasonViewController.instantiate(withStoryboard: "AnnictMeWorks")
        c.season = .autumn
        c.year = self.year
        let d = AnnictSeasonViewController.instantiate(withStoryboard: "AnnictMeWorks")
        d.season = .winter
        d.year = self.year
        return [a, b, c, d]
    }
    
    func tapedNavigationTitle(_ tapGestureRecognizer: UITapGestureRecognizer) {
        if isOpendPickerView == false {
            self.yearPickerView.defaultYear = year
            self.view.addSubview(yearPickerView!)
            self.initNavigationTitle(title: String(year) + " ▲")
            UIView.animate(withDuration: 0.2, animations: { [weak self] _ in
                self?.yearPickerView?.frame.origin.y = 0
            })
        } else {
            self.initNavigationTitle(title: String(year) + " ▼")
            UIView.animate(withDuration: 0.2, animations: { [weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.yearPickerView?.frame.origin.y = -weakSelf.yearPickerView.bounds.height
            }, completion: { [weak self] _ in
                self?.yearPickerView.removeFromSuperview()
                self?.reloadPagerTabStripView()
            })
        }
        isOpendPickerView = !isOpendPickerView
    }
    
    fileprivate func initNavigationTitle(title: String) {
        // タイトルを表示するラベルを作成
        let label = UILabel()
        label.textColor = .annictPink
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightThin)
        label.text = title
        label.sizeToFit()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapedNavigationTitle(_:)))
        label.addGestureRecognizer(gestureRecognizer)
        label.isUserInteractionEnabled = true
        navigationItem.titleView = label
    }
    
    fileprivate func getCurrentYear() -> Int {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.component(.year, from: Date())
    }
}

extension AnnictSeasonTabViewController: YearPickerViewDelegate {
    func didSelectYear(year: Int) {
        self.year = year
    }
}

