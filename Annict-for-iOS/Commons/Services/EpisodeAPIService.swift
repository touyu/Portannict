//
//  EpisodeAPIService.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/21.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import RxSwift
import Apollo

struct EpisodeAPIServiceEvent {
    let willCreateRecordEpisodeID = PublishSubject<GraphQLID>()
    let didCreatedRecord = PublishSubject<MinimumRecord>()
}

protocol EpisodeAPIServiceType {
    var event: EpisodeAPIServiceEvent { get }
    var client: ApolloClient { get }
    
    func createRecord(episodeID: GraphQLID, comment: String?, ratingState: RatingState?, shareTwitter: Bool) -> Observable<CreateRecordMutation.Data>
}

final class EpisodeAPIService: BaseService, EpisodeAPIServiceType {
    let event = EpisodeAPIServiceEvent()
    let client = AnnictGraphQL.client

    let disposeBag = DisposeBag()

    func createRecord(episodeID: GraphQLID, comment: String?, ratingState: RatingState?, shareTwitter: Bool = false) -> Observable<CreateRecordMutation.Data> {
        event.willCreateRecordEpisodeID.onNext(episodeID)
        let query = CreateRecordMutation(episodeId: episodeID, comment: comment, ratingState: ratingState, shareTwitter: shareTwitter)
        let stream = client.rx.perform(mutation: query)
            .asObservable()
            .share(replay: 1)

        stream
            .map { $0.createRecord?.record?.fragments.minimumRecord }
            .filterNil()
            .bind(to: event.didCreatedRecord)
            .disposed(by: disposeBag)

        return stream
    }
}
