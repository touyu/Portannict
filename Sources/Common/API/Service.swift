//
//  Service.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/31.
//

import Foundation
import ComposableArchitecture

protocol ServiceType {
    func fetchHomeActivities(first: Int?, after: String?) -> Effect<GetFollowingActivitiesQuery.Data, APIError>
}

struct Service: ServiceType {
    func fetchHomeActivities(first: Int? = nil, after: String? = nil) -> Effect<GetFollowingActivitiesQuery.Data, APIError> {
        let query = GetFollowingActivitiesQuery(first: first, after: after)
        return APIClient.shared.fetchEffect(query: query)
    }
}

struct PreviewService: ServiceType {
    func fetchHomeActivities(first: Int?, after: String?) -> Effect<GetFollowingActivitiesQuery.Data, APIError> {
        return .none
    }
}

