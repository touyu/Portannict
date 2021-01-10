//
//  Model+Extension.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/07.
//

import Foundation
import SwiftUI
import SwiftDate

extension GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.Edge.Node {
    enum ActivityItem {
        case none
        case record(AsRecord)
        case review(AsReview)
        case status(AsStatus)
        case multipleRecord(AsMultipleRecord)
    }

    var activityItem: ActivityItem {
        if let record = asRecord {
            return .record(record)
        }

        if let review = asReview {
            return .review(review)
        }

        if let status = asStatus {
            return .status(status)
        }

        if let multi = asMultipleRecord {
            return .multipleRecord(multi)
        }

        return .none
    }
}


extension RatingState {
    var color: Color {
        switch self {
        case .great:
            return .blue
        case .good:
            return .green
        case .average:
            return .orange
        case .bad:
            return .gray
        default:
            return .black
        }
    }

    var title: String {
        switch self {
        case .great:
            return "とても良い"
        case .good:
            return "良い"
        case .average:
            return "普通"
        case .bad:
            return "良くない"
        default:
            return ""
        }
    }
}

extension StatusState {
    var title: String {
        switch self {
        case .watching:
            return "見てる"
        case .wannaWatch:
            return "見たい"
        case .watched:
            return "見た"
        case .onHold:
            return "一時中断"
        case .stopWatching:
            return "視聴中止"
        default:
            return ""
        }
    }
}

extension Media {
    var localizedText: String {
        switch self {
        case .movie:
            return "映画"
        case .tv:
            return "TV"
        case .ova:
            return "OVA"
        case .web:
            return "Web"
        default:
            return "その他"
        }
    }
}

extension UserFragment {
    static var dummy = UserFragment(id: "user", name: "touyu", username: "touyu", description: "")
}

// GraphQL

extension SearchWorksBySeasonQuery.Data.SearchWork {
    var edgesOrEmpty: [Edge?] {
        return edges ?? []
    }
}
