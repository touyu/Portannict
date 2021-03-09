//
//  AnnictSeason.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/10.
//

import Foundation

struct AnnictSeason: Equatable {
    let year: Int
    let season: Season

    static var current: AnnictSeason {
        return .init(year: Date().year, season: .current)
    }

    var next: AnnictSeason {
        var newYear = self.year
        if season == .autumn {
            newYear += 1
        }
        return .init(year: newYear, season: season.next)
    }

    var previous: AnnictSeason {
        var newYear = self.year
        if season == .winter {
            newYear -= 1
        }
        return .init(year: newYear, season: season.previous)
    }

    var id: String {
        return "\(year)-\(season.rawValue)"
    }

    var title: String {
        if self == AnnictSeason.current {
            return "今期"
        }
        switch self {
        case .current:
            return "今期"
        case AnnictSeason.current.next:
            return "来期"
        case AnnictSeason.current.previous:
            return "前期"
        default:
            return "\(year)年 \(season.localizedText)"
        }
    }

    enum Season: String, Equatable {
        case winter
        case spring
        case summer
        case autumn

        static var current: Season {
            switch Date().month {
            case 1...3:
                return .winter
            case 4...6:
                return .spring
            case 7...9:
                return .summer
            case 10...12:
                return .autumn
            default:
                fatalError("Not found season")
            }
        }

        var localizedText: String {
            switch self {
            case .winter:
                return "冬"
            case .spring:
                return "春"
            case .summer:
                return "夏"
            case .autumn:
                return "秋"
            }
        }

        var next: Season {
            switch self {
            case .winter:
                return .spring
            case .spring:
                return .summer
            case .summer:
                return .autumn
            case .autumn:
                return .winter
            }
        }

        var previous: Season {
            switch self {
            case .winter:
                return .autumn
            case .spring:
                return .winter
            case .summer:
                return .spring
            case .autumn:
                return .summer
            }
        }
    }
}

