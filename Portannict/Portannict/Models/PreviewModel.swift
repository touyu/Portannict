//
//  PreviewModel.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/23.
//

import Foundation

struct PreviewModel {
    static var work: Work {
        Work(title: "やはり俺の青春ラブコメは間違っている。完")
    }

    static var activityStatus: ActivityStatus {
        ActivityStatus(work: work)
    }

    static var activity: Activity {
        Activity(action: .status, status: activityStatus)
    }

    static var activities: [Activity] {
        var result = [Activity]()
        for _ in 0..<30 {
            result.append(activity)
        }
        print(result)
        return result
    }
}
