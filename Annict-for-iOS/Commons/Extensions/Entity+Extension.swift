//
//  Entity.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/03/12.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import Foundation

extension MinimumEpisode {
    var numberAndTitle: String {
        var result = ""

        if let numberText = numberText {
            result = "\(numberText) "
        }

        if let title = title {
            result += title
        }

        return result
    }
}

extension HomeViewReactor.Activity {
    enum ItemType {
        case status(AsStatus)
        case record(AsRecord)
        case review(AsReview)
        case multipleRecord(AsMultipleRecord)
        case unknown
    }

    var itemType: ItemType {
        if let e = asStatus {
            return .status(e)
        }

        if let e = asRecord {
            return .record(e)
        }

        if let e = asReview {
            return .review(e)
        }

        if let e = asMultipleRecord {
            return .multipleRecord(e)
        }

        return .unknown
    }
    
    var work: MinimumWork? {
        get {
            switch itemType {
            case .status(let item):
                return item.work.fragments.minimumWork
            case .record(let item):
                return item.work.fragments.minimumWork
            case .review(let item):
                return item.fragments.review.work.fragments.minimumWork
            case .multipleRecord(let item):
                return item.work.fragments.minimumWork
            case .unknown:
                return nil
            }
        }
        set {
            guard let work = newValue else { return }
            asStatus?.work.fragments.minimumWork = work
            asRecord?.work.fragments.minimumWork = work
            asReview?.fragments.review.work.fragments.minimumWork = work
            asMultipleRecord?.work.fragments.minimumWork = work
        }
    }
}
