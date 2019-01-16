//
//  ProfileViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import Apollo
import XLPagerTabStrip

final class ProfileViewController: ButtonBarPagerTabStripViewController, StoryboardView {
    enum Const {
        static let normalTextColor = UIColor(hex: 0x595959)
        static let selectedBackgroundColor = UIColor(hex: 0xFF7187)
        static let selectedTextColor = UIColor.white
    }
    
    typealias Reactor = ProfileViewReactor
    
    var disposeBag = DisposeBag()
    
    @IBOutlet private weak var headerView: ProfileHeaderView!
    @IBOutlet private weak var headerViewTopConstraint: NSLayoutConstraint!
    
    private var buttonMarkView: ButtonMarkView? {
        return buttonBarView as? ButtonMarkView
    }
    
    private var headerViewFittingCompressedHeight: CGFloat {
        return headerView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
    }
    
    private var insetTop: CGFloat {
        return headerViewFittingCompressedHeight + buttonBarView.bounds.height
    }
    
    override func viewDidLoad() {
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.buttonBarItemTitleColor = Const.normalTextColor
        settings.style.buttonBarLeftContentInset = 24
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            newCell?.label.textColor = Const.selectedTextColor
            oldCell?.label.textColor = Const.normalTextColor
        }
        
        reactor = Reactor()
        
        buttonMarkView?.selectedMarkView.backgroundColor = Const.selectedBackgroundColor
        
        super.viewDidLoad()
    }
    
    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .map { Reactor.Action.fetch }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.viewer }
            .filterNil()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] viewer in
                self?.headerView.prepare(user: viewer)
                self?.refreshTableViewContentInsetTop()
            })
            .disposed(by: disposeBag)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let vc1 = ProfileWorksViewController.loadStoryboard(reactor: .init(statusState: .watching))
        let vc2 = ProfileWorksViewController.loadStoryboard(reactor: .init(statusState: .wannaWatch))
        let vc3 = ProfileWorksViewController.loadStoryboard(reactor: .init(statusState: .watched))
        let vc4 = ProfileWorksViewController.loadStoryboard(reactor: .init(statusState: .onHold))
        let vc5 = ProfileWorksViewController.loadStoryboard(reactor: .init(statusState: .stopWatching))
        let vcs = [vc1, vc2, vc3, vc4, vc5]
        vcs.forEach { $0.delegate = self }
        return vcs
    }
    
    private func refreshTableViewContentInsetTop() {
        viewControllers
            .compactMap { ($0 as? CollectionViewProvider)?.collectionView }
            .forEach {
                $0.contentInset.top = insetTop
                $0.scrollIndicatorInsets.top = insetTop
                $0.contentOffset.y = -insetTop
            }
    }
}

extension ProfileViewController: ChildPagerTabStripDelegate {
    func collectionViewWillDisplay(_ collectionView: UICollectionView) {
        collectionView.contentInset.top = insetTop
        collectionView.scrollIndicatorInsets.top = insetTop
        
        var insetTops = viewControllers
            .compactMap { ($0 as? CollectionViewProvider)?.collectionView }
            .filter { $0 != collectionView }
            .map { min($0.contentOffset.y, -40) }
        insetTops.append(-insetTop)
        collectionView.contentOffset.y = insetTops.max() ?? 0
    }
    
    func collectionViewDidScroll(_ collectionView: UICollectionView) {
        headerViewTopConstraint.constant = max(-collectionView.contentOffset.y - insetTop, -headerViewFittingCompressedHeight)
        
        let tableViews = viewControllers
            .compactMap { ($0 as? CollectionViewProvider)?.collectionView }
            .filter { $0 != collectionView }
        
        tableViews
            .forEach { $0.contentOffset.y = collectionView.contentOffset.y }
    }
}

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

extension UIColor {
    public convenience init(from fColor: UIColor, to tColor: UIColor, with per: CGFloat) {
        var fR: CGFloat = 0, fG: CGFloat = 0, fB: CGFloat = 0, fA: CGFloat = 0
        var tR: CGFloat = 0, tG: CGFloat = 0, tB: CGFloat = 0, tA: CGFloat = 0
        
        fColor.getRed(&fR, green: &fG, blue: &fB, alpha: &fA)
        tColor.getRed(&tR, green: &tG, blue: &tB, alpha: &tA)
        
        let r: CGFloat = (tR - fR) * per + fR
        let g: CGFloat = (tG - fG) * per + fG
        let b: CGFloat = (tB - fB) * per + fB
        let a: CGFloat = (tA - fA) * per + fA
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
