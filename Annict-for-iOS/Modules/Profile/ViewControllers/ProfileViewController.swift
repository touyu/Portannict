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

final class ProfileViewController: UIViewController, StoryboardView {
    typealias Reactor = ProfileViewReactor
    
    enum Section: Int, CaseIterable {
        case userInfo
        case works
    }

    @IBOutlet private weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        reactor = Reactor()
        
        super.viewDidLoad()
        
        prepareTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .take(1)
            .map { Reactor.Action.fetch }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.viewer }
            .filterNil()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.allWorks }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func prepareTableView() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UserInfoTableViewCell.self,
                           UserWorksWithSectionTitleCell.self)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let reactor = reactor else { return 0 }
        switch Section(rawValue: section)! {
        case .userInfo:
            return 1
        case .works:
            return reactor.currentState.allWorks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section)! {
        case .userInfo:
            let cell = tableView.dequeueReusableCell(classType: UserInfoTableViewCell.self, for: indexPath)
            guard let viewer = reactor?.currentState.viewer else { return cell }
            cell.prepare(user: viewer)
            return cell
        case .works:
            let cell = tableView.dequeueReusableCell(classType: UserWorksWithSectionTitleCell.self, for: indexPath)
            guard let allWorks = reactor?.currentState.allWorks else { return cell }
            cell.prepare(title: StatusState.values[indexPath.item].localizedText, works: allWorks[indexPath.item])
            return cell
        }
    }
}

extension StatusState {
    static var values: [StatusState] {
        return [.watching, .wannaWatch, .watched, .onHold, .stopWatching]
    }
    
    var localizedText: String {
        switch self {
        case .watching:
            return "見てる"
        case .wannaWatch:
            return "見たい"
        case .watched:
            return "見た"
        case .onHold:
            return "中断"
        case .stopWatching:
            return "中止"
        case .noState, .__unknown:
            return ""
        }
    }
}

extension GetViewerWorksQuery.Data.Viewer.Work {
    var value: [Edge.Node] {
        guard let edges = edges else { return []}
        return edges.compactMap { $0?.node }
    }
}

extension Array: GraphQLSelectionSet where Element: GraphQLSelectionSet {
    public init(unsafeResultMap: ResultMap) {
        let resultMaps = unsafeResultMap["resultMap"] as! [ResultMap]
        let sets = resultMaps.map(Element.init)
        do {
            try self.init(sets)
        } catch {
            self.init([])
        }
    }
    
    public static var selections: [GraphQLSelection] {
        return []
    }
    
    public var resultMap: ResultMap {
        return ["resultMap": self.map { $0.resultMap }]
    }
}

extension GraphQLSelectionSet {
    func iSEqual(_ value: GraphQLSelectionSet) -> Bool {
        return (self.resultMap as NSDictionary).isEqual(to: value.resultMap as [AnyHashable : Any])
    }
}

extension ObservableType where E: GraphQLSelectionSet {
    func distinctUntilChanged() -> Observable<Self.E> {
        return distinctUntilChanged { $0.iSEqual($1) }
    }
}
