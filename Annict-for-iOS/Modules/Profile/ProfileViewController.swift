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

    @IBOutlet private weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    
    private var client: ApolloClient? = {
        let configuration = URLSessionConfiguration.default
        guard let token = UserDefaultsRepository.fetch(forKey: .accessToken, type: String.self) else { return nil }
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"]
        let url = URL(string: "https://api.annict.com/graphql")!
        let transport = HTTPNetworkTransport(url: url, configuration: configuration)
        return ApolloClient(networkTransport: transport)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetch()
    }

    func bind(reactor: Reactor) {

    }
    
    private func fetch() {
        guard let client = client else { return }
        let states: [StatusState] = [.watching, .wannaWatch, .watched, .onHold, .stopWatching]
        let queries = states.compactMap(GetViewerWorksQuery.init)
        let requests = queries.compactMap { client.rx.fetch(query: $0).asObservable() }
        Observable.zip(requests)
            .subscribe(onNext: { data in
                for elem in data {
                    elem.viewer?.works?.value
                }
            })
            .disposed(by: disposeBag)
        
        client.rx
            .fetch(query: GetViewerInfoQuery())
            .subscribe(onSuccess: { data in
                
            })
            .disposed(by: disposeBag)
    }
    
    private func prepareTableView() {
        tableView.dataSource = self
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension GetViewerWorksQuery.Data.Viewer.Work {
    var value: [Edge.Node] {
        guard let edges = edges else { return []}
        return edges.compactMap { $0?.node }
    }
}
