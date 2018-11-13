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
import Apollo

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

        let configuration = URLSessionConfiguration.default
        guard let token = UserDefaultsRepository.fetch(forKey: .accessToken, type: String.self) else { return }
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"]
        let url = URL(string: "https://api.annict.com/graphql")!
        let transport = HTTPNetworkTransport(url: url, configuration: configuration)
        let query = GetViewerWatchingEpisodesQuery()
        ApolloClient(networkTransport: transport).rx
            .fetch(query: query)
            .subscribe(onSuccess: { data in
                guard let edges = data.viewer?.works?.edges else { return }
                let episodes = edges.compactMap { $0?.node?.episodes?.edges }
                let test = episodes.map { eps in
                    return eps
                        .compactMap { $0?.node }
                        .filter { $0.viewerRecordsCount == 0 }
                        .min(by: { $0.annictId < $1.annictId })
                }
                print(test.map { $0?.title })
            })
            .disposed(by: disposeBag)
    }

    func bind(reactor: Reactor) {

    }
    
    private func aaa(data: GetViewerWatchingEpisodesQuery.Data) {
        guard let viewer = data.viewer else { return }
        let ddd = viewer.works?.edges
        ddd.superFlatMap { aaa in
            
        }
        viewer.works?.edges.flatMap { aaa in
            aaa
        }
    }
}

extension Optional where Wrapped: Optional<Array<Any>> {
    func superFlatMap(transform: () -> Wrapped) {
        sel
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
