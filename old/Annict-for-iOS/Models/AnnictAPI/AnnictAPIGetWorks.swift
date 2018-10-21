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
    case noSelect = "no_select"
    case wannaWatch = "wanna_watch"
    case watching = "watching"
    case watched = "watched"
    case onHold = "on_hold"
    case stopWatching = "stop_watching"
    
    var localizedString: String {
        return self.rawValue.localized(withTableName: "AnnictBaseLocalizable")
    }
    
    static func getList() -> [AnimeStatus] {
        return [.noSelect, .wannaWatch, watching, .watched, .onHold, .stopWatching]
    }
    
    static func getLocalizedList() -> [String] {
        return [AnimeStatus.noSelect.localizedString,
         AnimeStatus.wannaWatch.localizedString,
         AnimeStatus.watching.localizedString,
         AnimeStatus.watched.localizedString,
         AnimeStatus.onHold.localizedString,
         AnimeStatus.stopWatching.localizedString]
    }
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
    
    static var current: Season {
        let calendar = Calendar(identifier: .gregorian)
        let month = calendar.component(.month, from: Date())
        switch month {
        case 1, 2, 3:
            return .winter
        case 4, 5, 6:
            return .spring
        case 7, 8, 9:
            return .summer
        default:
            return .autumn
        }
    }
    
    var number: Int {
        switch self {
        case .spring:
            return 0
        case .summer:
            return 1
        case .autumn:
            return 2
        case .winter:
            return 3
        }
    }
}

extension AnnictAPI {
    
    
    // MARK: - GetWorks
    
    class GetWorks: AnnictAPIRequest {
        enum Sort: String {
            case id = "sort_id"
            case season = "sort_season"
            case watchersCount = "sort_watchers_count"
        }
        
        typealias FilterStatus = AnimeStatus
        
        var id: Int?
        var page: Int
        var perPage: Int
        var sort: Sort
        var order: Order
        
        var filterStatus: FilterStatus?
        var filterSeason: (year: Int, season: Season?)?
        var filterTitle: String?
        
        init(id: Int? = nil,
             page: Int = 1,
             parPage: Int = 30,
             filterStatus: FilterStatus? = nil,
             filterSeason: (year: Int, season: Season?)? = nil,
             filterTitle: String? = nil,
             sort: Sort = .season) {
            self.id = id
            self.page = page
            self.perPage = parPage
            self.sort = sort
            self.order = .descending
            self.filterStatus = filterStatus
            self.filterSeason = filterSeason
            self.filterTitle = filterTitle
        }
        
        typealias Response = AnnictWorksResponse
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/v1/works"
        }
        
        var parameters: Any? {
            var params:[String: Any] = [
                "access_token": AnnictConsts.accessToken,
                "page": page,
                "per_page": perPage,
                sort.rawValue: order.rawValue,
                ]
            params["filter_ids"] = id ?? nil
            params["filter_status"] = filterStatus?.rawValue ?? nil
            params["filter_title"] = filterTitle ?? nil
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
