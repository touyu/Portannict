//
//  RecordViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class RecordViewController: UIViewController, StoryboardView {
    typealias Reactor = RecordViewReactor

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableFooterView = UIView()
        }
    }
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func bind(reactor: Reactor) {

    }
}

extension RecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension RecordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = PostRecordViewController.loadStoryboard()
        vc.transitioningDelegate = vc.transitioner
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
}
