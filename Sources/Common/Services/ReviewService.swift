//
//  ReviewService.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/03/09.
//

import Foundation
import ComposableArchitecture

struct ReviewService {
    static func fetch(workAnnictId: Int, first: Int, after: String?) -> Effect<SearchWorkReviewsQuery.Data.SearchWork.Node.Review, APIError> {
        return APIClient.shared.fetchEffect(query: SearchWorkReviewsQuery(workAnnictId: workAnnictId, first: first))
            .compactMap { $0.searchWorks?.nodes?.first??.reviews }
            .eraseToEffect()
    }
}

