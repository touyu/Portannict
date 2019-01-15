//
//  WorkViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/12/01.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import Hero

final class WorkViewController: UIViewController, StoryboardView {
    typealias Reactor = WorkViewReactor

    var disposeBag = DisposeBag()

    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet private(set) weak var tableView: UITableView!
    @IBOutlet private(set) weak var gradationView: GradationView!
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    
    private var prepareImageView: ((UIImageView) -> Void)?
    
    private var prepareHero: ((WorkViewController) -> Void)?
    
    private let mergin: CGFloat = UIScreen.main.bounds.width + 40 - 120 - 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        prepareHero?(self)
        
        imageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:))))
        
        gradationView.prepare(type: .top, colors: [UIColor.white.withAlphaComponent(0),
                                                   UIColor.white.withAlphaComponent(0.5),
                                                   .white])
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func bind(reactor: Reactor) {
        tableView.rx.contentOffset
            .subscribe(onNext: { [weak self] value in
                print(value)
                self?.adjustTopConstraint(contentOffsetY: value.y)
            })
            .disposed(by: disposeBag)
    }
    
    private func adjustTopConstraint(contentOffsetY: CGFloat) {
        print(-contentOffsetY + imageView.bounds.height)
        topConstraint.constant = max(-mergin - contentOffsetY + imageView.bounds.height, 80)
    }
    
    func prepareHero(handler: @escaping ((WorkViewController) -> Void)) {
        prepareHero = handler
    }
    
    private func prepareTableView() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        topConstraint.constant = imageView.bounds.height
        tableView.backgroundColor = .clear
        tableView.contentInset.top = mergin
        tableView.contentOffset.y = -tableView.contentInset.top
        tableView.panGestureRecognizer.addTarget(self, action: #selector(self.handlePanGesture(_:)))
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(WorkTitleTableViewCell.self)
    }
    
    @objc func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
        print("handlePanGesture")
        guard tableView.contentOffset.y < -mergin else {
            print("handlePanGesture Cancel")
            Hero.shared.cancel()
            return
        }
        
        let translation = panGesture.translation(in: nil)
        let progress = translation.y / view.bounds.height
        
        switch panGesture.state {
        case .began:
            hero.dismissViewController()
        case .changed:
            Hero.shared.update(progress)
        default:
            let velocity = panGesture.velocity(in: nil).y
            
            // dismiss完成の条件のチェック
            if progress + abs(velocity) / view.bounds.height > 0.5 {
                Hero.shared.finish(animate: true)
            } else {
                Hero.shared.cancel()
            }
        }
    }
}

extension WorkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
//        switch indexPath.row {
//        case 0:
//            guard let currentState = reactor?.currentState else { return UITableViewCell() }
//            let cell = tableView.dequeueReusableCell(classType: WorkTitleTableViewCell.self, for: indexPath)
//            cell.configure(title: currentState.initialTitle, titleLabelHeroID: currentState.titleLabelHeroID)
//            return cell
//        default:
//            return UITableViewCell()
//        }
    }
}

final class NacigatarBar: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor(hex: 0xD8D8D8)
        roundedRectangleFilter()
    }
}
