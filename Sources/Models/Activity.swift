//
//  Activity.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/23.
//

import Foundation

enum ActivityAction {
    case status
}

struct Activity: Identifiable {
    var id = UUID()
    let action: ActivityAction
    var status: ActivityStatus?
}

//enum Activity {
//    case status(ActivityStatus)
//
//    var status: ActivityStatus {
//        switch self {
//        case .status(let item):
//            return item
//        }
//    }
//}
//
//extension Activity: Identifiable {
//    var id: UUID {
//        switch self {
//        case .status(let item):
//            return item.id
//        }
//    }
//}

struct ActivityStatus: Identifiable {
    var id = UUID()
    var work: Work
}
