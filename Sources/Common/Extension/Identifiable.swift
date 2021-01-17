//
//  Identifiable.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/18.
//

import Foundation

extension Identifiable where Self: Hashable {
    public typealias ID = Self
    public var id: Self { self }
}
