//
//  WorkEpisodeViewViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/04/02.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import XLPagerTabStrip

final class WorkEpisodeViewViewController: ChildPagerViewController, StoryboardView {
    typealias Reactor = WorkEpisodeViewViewReactor

    var disposeBag = DisposeBag()

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func provideScrollView() -> UIScrollView? {
        return tableView
    }
    
    func bind(reactor: Reactor) {

    }

}

extension WorkEpisodeViewViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "エピソード")
    }
}
