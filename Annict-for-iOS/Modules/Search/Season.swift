//
//  Season.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/21.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import Foundation

struct Season {
    enum Name: String {
        case spring = "spring"
        case summer = "summer"
        case autumn = "autumn"
        case winter = "winter"
        
        var localizedText: String {
            switch self {
            case .spring:
                return "春"
            case .summer:
                return "夏"
            case .autumn:
                return "秋"
            case .winter:
                return "冬"
            }
        }
    }
    let name: Name
    let year: Int
    
    var value: String {
        return "\(year)-\(name.rawValue)"
    }
    
    static var currentName: Name {
        switch Date().month {
        case 4, 5, 6:
            return .spring
        case 7, 8, 9:
            return .summer
        case 10, 11, 12:
            return .autumn
        case 1, 2, 3:
            return .winter
        default:
            return .spring
        }
    }
    
    static var current: Season {
        return Season(name: currentName, year: Date().year)
    }
    
    func next() -> Season {
        var name = self.name
        var year = self.year
        
        switch name {
        case .spring:
            name = .summer
        case .summer:
            name = .autumn
        case .autumn:
            name = .winter
            year += 1
        case .winter:
            name = .spring
        }
        return Season(name: name, year: year)
    }
    
    func previous(_ num: Int = 1) -> Season {
        var name = self.name
        var year = self.year
        
        switch name {
        case .spring:
            name = .winter
        case .summer:
            name = .spring
        case .autumn:
            name = .summer
        case .winter:
            name = .autumn
            year -= 1
        }
        
        if num == 1 {
            return Season(name: name, year: year)
        } else {
            return Season(name: name, year: year).previous(num - 1)
        }
    }
}

extension Date {
    var year: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return Int(dateFormatter.string(from: self))!
    }
    
    var month: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return Int(dateFormatter.string(from: self))!
    }
}
