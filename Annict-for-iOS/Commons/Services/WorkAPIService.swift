//
//  WorkAPIService.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/19.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import RxSwift
import Apollo

struct WorkAPIServiceEvent {
    let updateWorkState = PublishSubject<MinimumWork>()
}

protocol WorkAPIServiceType {
    var event: WorkAPIServiceEvent { get }
    var client: ApolloClient { get }

    func updateStatus(state: StatusState, workId: GraphQLID) -> Observable<MinimumWork>
}

final class WorkAPIService: BaseService, WorkAPIServiceType {
    let event = WorkAPIServiceEvent()

    let client = AnnictGraphQL.client
    let disposeBag = DisposeBag()

    func updateStatus(state: StatusState, workId: GraphQLID) -> Observable<MinimumWork> {
        let mutation = UpdateStatusMutation(state: state, workId: workId)
        let stream = AnnictGraphQL.client.rx.perform(mutation: mutation)
            .asObservable()
            .map { $0.updateStatus!.work!.fragments.minimumWork }
            .share(replay: 1)
        
        stream
            .subscribe(onNext: { [weak self] work in
                self?.event.updateWorkState.onNext(work)
            })
            .disposed(by: disposeBag)
            
        return stream
    }
}
