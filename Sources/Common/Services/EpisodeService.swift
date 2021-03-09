//
//  EpisodeService.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/03/09.
//

import Foundation
import ComposableArchitecture

struct EpisodeService {
    static func fetch(workAnnictId: Int, first: Int, after: String?) -> Effect<SearchWorkEpisodesQuery.Data.SearchWork.Node.Episode, APIError> {
        return APIClient.shared.fetchEffect(query: SearchWorkEpisodesQuery(workAnnictId: workAnnictId, first: first, after: after))
            .compactMap { $0.searchWorks?.nodes?.first??.episodes }
            .eraseToEffect()
    }
}
