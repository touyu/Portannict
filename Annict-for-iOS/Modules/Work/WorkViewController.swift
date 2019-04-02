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
import SnapKit

final class WorkViewController: ParentPagerViewController, StatusBarAnimatable, StoryboardView {
    typealias Reactor = WorkViewReactor

    @IBOutlet weak var headerView: WorkHeaderView!
    
    private var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        button.layer.cornerRadius = 28 / 2
        return button
    }()
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        prepareButtonBar()
        isEnableTopSafeAreaInset = true
        super.viewDidLoad()
        
        prepareConstraints()
    }
    
    override var prefersStatusBarHidden: Bool {
        return statusBarManager.isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideStatusBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        showStatusBar()
    }
    
    override func headerView(_ parentPager: ParentPager) -> UIView {
        return headerView
    }
    
    override func viewControllers(_ parentPager: ParentPager) -> [ChildPagerViewController] {
        return [WorkEpisodeViewViewController.loadStoryboard(),
                WorkEpisodeViewViewController.loadStoryboard(),
                WorkEpisodeViewViewController.loadStoryboard()]
    }
    
    override func scrollViewWillDisplay(_ scrollView: UIScrollView) {
        super.scrollViewWillDisplay(scrollView)
        
        scrollView.panGestureRecognizer.addTarget(self, action: #selector(handlePanGesture(_:)))
    }
    
    func bind(reactor: Reactor) {        
        closeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.work }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] work in
                self?.headerView.configure(work: work)
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.heroID }
            .filterNil()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] heroID in
                self?.hero.isEnabled = true
                self?.headerView.workImageView.hero.id = heroID
            })
            .disposed(by: disposeBag)
    }
    
    private func prepareConstraints() {
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 28, height: 28))
            $0.top.equalTo(view).inset(20)
            $0.right.equalTo(view).inset(20)
        }
    }
    
    @objc func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
        guard let scrollView = panGesture.view as? UIScrollView else { return }
//        print(scrollView.contentOffset.y, insetTop)

//        let translation = panGesture.translation(in: nil)
//        let progress = translation.y / view.bounds.height\\


        let safeAreaInsetTop: CGFloat = 44
        let insetTop = self.insetTop - safeAreaInsetTop
        
        if scrollView.contentOffset.y > -insetTop {
            Hero.shared.cancel()
            return
        }
//
        let progress = -(scrollView.contentOffset.y + insetTop) / view.bounds.height * 2
//        print(progress)

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

extension WorkViewController {
    static func present(fromVC: UIViewController, reactor: Reactor) {
        let vc = WorkViewController.loadStoryboard(reactor: reactor)
        fromVC.present(vc, animated: true, completion: nil)
    }
}

extension WorkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
