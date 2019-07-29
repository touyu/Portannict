//
//  URLConvertible.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/25.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import Foundation

protocol URLConvertible {
    func asURL() -> URL?
}

extension String: URLConvertible {
    func asURL() -> URL? {
        return URL(string: self)
    }
}

extension URL: URLConvertible {
    func asURL() -> URL? {
        return self
    }
}
