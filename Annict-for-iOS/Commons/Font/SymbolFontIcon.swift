//
//  SymbolFontIcon.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/12/20.
//

import Foundation

enum SymbolFontIcon: Int, CaseIterable {
    case house
    case houseFill
    case pencil
    case pencilCircle
    case pencilCircleFill
    case magnifyingglassCircle
    case magnifyingglassCircleFill
    case person
    case personFill

    var charactor: String {
        switch self {
        case .house:
            return "􀎞"
        case .houseFill:
            return "􀎟"
        case .pencil:
            return "􀈊"
        case .pencilCircle:
            return "􀈋"
        case .pencilCircleFill:
            return "􀈌"
        case .magnifyingglassCircle:
            return "􀒒"
        case .magnifyingglassCircleFill:
            return "􀒓"
        case .person:
            return "􀉩"
        case .personFill:
            return "􀉪"
        }
    }
}
