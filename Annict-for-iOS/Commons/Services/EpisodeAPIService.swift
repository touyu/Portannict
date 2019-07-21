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
}

protocol EpisodeAPIServiceType {
    var event: EpisodeAPIServiceEvent { get }
    var client: ApolloClient { get }
    
    func createRecord(episodeID: GraphQLID, comment: String?) -> Observable<CreateRecordMutation.Data> 
}

final class EpisodeAPIService: BaseService, EpisodeAPIServiceType {
    let event = EpisodeAPIServiceEvent()
    let client = AnnictGraphQL.client
    
    func createRecord(episodeID: GraphQLID, comment: String?) -> Observable<CreateRecordMutation.Data> {
        event.willCreateRecordEpisodeID.onNext(episodeID)
        let query = CreateRecordMutation(episodeId: episodeID, comment: comment)
        return client.rx.perform(mutation: query)
            .asObservable()
    }
}
