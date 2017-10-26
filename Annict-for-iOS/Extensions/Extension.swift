//
//  Extension.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/10/19.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

extension StatusState {
    func localized() -> String {
        return rawValue.localized(withTableName: "AnnictBaseLocalizable")
    }
}

extension RatingState {
    var color: UIColor {
        switch self {
        case .great:
            return UIColor(hex: 0x00B0FF)
        case .good:
            return UIColor(hex: 0x00C853)
        case .average:
            return UIColor(hex: 0xFF6D00)
        case .bad:
            return UIColor(hex: 0x757575)
        }
    }
    
    func localized() -> String {
        return rawValue.localized(withTableName: "AnnictBaseLocalizable")
    }
}

// -------------------------------------------------------------------------------------

protocol URLConvertible {
    func asURL() throws -> URL
}

extension String: URLConvertible {
    func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw PError.invalidURL(url: self) }
        return url
    }
}

extension URL: URLConvertible {
    func asURL() throws -> URL { return self }
}

// -------------------------------------------------------------------------------------
