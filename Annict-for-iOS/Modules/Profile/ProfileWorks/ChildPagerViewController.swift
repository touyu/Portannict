//
//  ChildPagerViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/03/27.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import XLPagerTabStrip

protocol ScrollViewProvider {
    var delegate: ChildPagerTabStripDelegate? { get set }
    func provideScrollView() -> UIScrollView?
}

protocol ChildPagerTabStripDelegate: class {
    func scrollViewWillDisplay(_ scrollView: UIScrollView)
    func scrollViewDidScrolled(_ scrollView: UIScrollView)
}

class ChildPagerViewController: UIViewController, ScrollViewProvider, UIScrollViewDelegate {
    weak var delegate: ChildPagerTabStripDelegate?
    
    private var observation: NSKeyValueObservation?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        observation?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeContentSize()
        if let scrollView = provideScrollView() {
            scrollView.delegate = self
            delegate?.scrollViewWillDisplay(scrollView)
        }
    }
    
    func provideScrollView() -> UIScrollView? {
        fatalError("Unimplemented provideScrollView()")
    }
    
    private func observeContentSize() {
        observation = provideScrollView()?.observe(\.contentSize, options: [.new]) { collectionView, value in
//            print(value.newValue)
//            print(collectionView.frame.size)
            guard let newValue = value.newValue else { return }
            let newBottomInset = collectionView.frame.size.height - newValue.height
            if newBottomInset > 0 {
                collectionView.contentInset.bottom = collectionView.frame.size.height - newValue.height
            } else {
                collectionView.contentInset.bottom = 0
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScrolled(scrollView)
    }
}

