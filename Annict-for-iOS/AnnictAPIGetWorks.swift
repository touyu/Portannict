//
//  AnnictAPIGetWorks.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/12.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import APIKit
import Himotoki

enum AnimeStatus: String {
    case wannaWatch = "wanna_watch"
    case watching = "watching"
    case watched = "watched"
    case onHold = "on_hold"
    case stopWatching = "stop_watching"
}

extension AnnictAPI {
    
    
    // MARK: - GetWorks
    
    class GetWorks: AnnictAPIRequest {
        enum Sort: String {
            case id = "sort_id"
            case season = "sort_season"
            case watchersCount = "sort_watchers_count"
        }
        
        enum Order: String {
            case ascending = "asc"
            case descending = "desc"
        }
        
        enum Season: String {
            case spring = "spring"
            case summer = "summer"
            case autumn = "autumn"
            case winter = "winter"
        }
        
        typealias FilterStatus = AnimeStatus
        
        var page: Int
        var sort: Sort
        var order: Order
        
        var filterStatus: FilterStatus?
        var filterSeason: (year: Int, season: Season?)?
        
        init(page: Int = 1,
             filterStatus: FilterStatus? = nil,
             filterSeason: (year: Int, season: Season?)? = nil) {
            self.page = page
            self.sort = .season
            self.order = .descending
            self.filterStatus = filterStatus
            self.filterSeason = filterSeason
        }
        
        typealias Response = AnnictWorksResponse
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/v1/me/works"
        }
        
        var parameters: Any? {
            var params:[String: Any] = [
                "access_token": AnnictConsts.accessToken,
                "page": page,
                "per_page": 30,
                sort.rawValue: order.rawValue,
                ]
            if let filterStatus = filterStatus {
                params["filter_status"] = filterStatus.rawValue
            }
            if let filterSeason = filterSeason {
                let season = filterSeason.season?.rawValue ?? "all"
                params["filter_season"] = "\(filterSeason.year)-\(season)"
            }
            return params
        }
    }
    
    
    // MARK: - GetMeWorks
    
    final class GetMeWorks: GetWorks {
        override var path: String {
            return "/v1/me/works"
        }
    }
}
