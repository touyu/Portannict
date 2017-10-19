//
//  GraphQL.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/10/14.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import Foundation

typealias FollowingActivity = GetViewerFollowingActivitiesQuery.Data.Viewer.FollowingActivity.Edge.Node

extension FollowingActivity {
    enum CellType {
        case status
        case record
        case review
        case multipleRecord
    }
    
    var cellType: CellType? {
        if let _ = asStatus {
            return .status
        }
        
        return nil
    }
}
