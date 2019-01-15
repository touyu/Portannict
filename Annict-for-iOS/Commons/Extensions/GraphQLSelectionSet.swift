//
//  GraphQLSelectionSet.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/28.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import RxSwift
import Apollo

extension Array: GraphQLSelectionSet where Element: GraphQLSelectionSet {
    public init(unsafeResultMap: ResultMap) {
        let resultMaps = unsafeResultMap["resultMap"] as! [ResultMap]
        let sets = resultMaps.map(Element.init)
        self = sets
    }
    
    public static var selections: [GraphQLSelection] {
        return []
    }
    
    public var resultMap: ResultMap {
        return ["resultMap": self.map { $0.resultMap }]
    }
}

extension GraphQLSelectionSet {
    func iSEqual(_ value: GraphQLSelectionSet) -> Bool {
        return (self.resultMap as NSDictionary).isEqual(to: value.resultMap as [AnyHashable : Any])
    }
}

extension Dictionary where Key == String, Value == Any? {
    static func == (lhs: Dictionary, rhs: Dictionary) -> Bool {
        return (lhs as NSDictionary).isEqual(to: rhs as [AnyHashable: Any])
    }
}

extension ObservableType where E: GraphQLSelectionSet {
    func distinctUntilChanged() -> Observable<Self.E> {
        return distinctUntilChanged { $0.resultMap == $1.resultMap }
    }
}
