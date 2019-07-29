//
//  ButtonMarkView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/03/27.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import XLPagerTabStrip

final class ButtonMarkView: ButtonBarView {
    lazy var selectedMarkView: UIView = {
        let mark = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: selectedMarkViewHeight))
        mark.layer.zPosition = -1
        return mark
    }()
    
    var selectedMarkViewHeight: CGFloat = 30 {
        didSet {
            updateSelectedMarkViewYPosition()
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        selectedBar.alpha = 0
        addSubview(selectedMarkView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        selectedBar.alpha = 0
        addSubview(selectedMarkView)
    }
    
    override func moveTo(index: Int, animated: Bool, swipeDirection: SwipeDirection, pagerScroll: PagerScroll) {
        super.moveTo(index: index, animated: animated, swipeDirection: swipeDirection, pagerScroll: pagerScroll)
        updateSelectedMarkViewPosition(index, animated: animated, swipeDirection: swipeDirection, pagerScroll: pagerScroll)
    }
    
    override func move(fromIndex: Int, toIndex: Int, progressPercentage: CGFloat, pagerScroll: PagerScroll) {
        super.move(fromIndex: fromIndex, toIndex: toIndex, progressPercentage: progressPercentage, pagerScroll: pagerScroll)
        
        let fromFrame = layoutAttributesForItem(at: IndexPath(item: fromIndex, section: 0))!.frame
        let numberOfItems = dataSource!.collectionView(self, numberOfItemsInSection: 0)
        
        var toFrame: CGRect
        
        if toIndex < 0 || toIndex > numberOfItems - 1 {
            if toIndex < 0 {
                let cellAtts = layoutAttributesForItem(at: IndexPath(item: 0, section: 0))
                toFrame = cellAtts!.frame.offsetBy(dx: -cellAtts!.frame.size.width, dy: 0)
            } else {
                let cellAtts = layoutAttributesForItem(at: IndexPath(item: (numberOfItems - 1), section: 0))
                toFrame = cellAtts!.frame.offsetBy(dx: cellAtts!.frame.size.width, dy: 0)
            }
        } else {
            toFrame = layoutAttributesForItem(at: IndexPath(item: toIndex, section: 0))!.frame
        }
        
        var targetFrame = fromFrame
        targetFrame.size.height = selectedMarkView.frame.size.height
        targetFrame.size.width += (toFrame.size.width - fromFrame.size.width) * progressPercentage
        targetFrame.origin.x += (toFrame.origin.x - fromFrame.origin.x) * progressPercentage
        
        selectedMarkView.frame = CGRect(x: targetFrame.origin.x, y: selectedMarkView.frame.origin.y, width: targetFrame.size.width, height: selectedMarkView.frame.size.height)
        selectedMarkView.roundedRectangleFilter()
    }
    
    func updateSelectedMarkViewPosition(_ index: Int, animated: Bool, swipeDirection: SwipeDirection, pagerScroll: PagerScroll) {
        var selectedMarkViewFrame = selectedMarkView.frame
        
        let selectedCellIndexPath = IndexPath(item: index, section: 0)
        let attributes = layoutAttributesForItem(at: selectedCellIndexPath)
        let selectedCellFrame = attributes!.frame
        
        selectedMarkViewFrame.size.width = selectedCellFrame.size.width
        selectedMarkViewFrame.origin.x = selectedCellFrame.origin.x
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.selectedMarkView.frame = selectedMarkViewFrame
            })
        } else {
            selectedMarkView.frame = selectedMarkViewFrame
        }
    }
    
    private func updateSelectedMarkViewYPosition() {
        var selectedBarFrame = selectedMarkView.frame
        selectedBarFrame.origin.y = (frame.size.height - selectedMarkViewHeight) / 2
        selectedBarFrame.size.height = selectedMarkViewHeight
        selectedMarkView.frame = selectedBarFrame
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateSelectedMarkViewYPosition()
    }
}
