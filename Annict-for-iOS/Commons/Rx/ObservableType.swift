//
//  ObservableType.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import RxSwift

public protocol OptionalType {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    public var value: Wrapped? {
        return self
    }
}

extension ObservableType where Element: OptionalType {
    func filterNil() -> Observable<Element.Wrapped> {
        return self.flatMap { element -> Observable<Element.Wrapped> in
            guard let value = element.value else {
                return Observable<Element.Wrapped>.empty()
            }
            return Observable<Element.Wrapped>.just(value)
        }
    }
}

extension ObservableType where Element: Sequence {
    func mapMany<R>(_ transform: @escaping (Element.Element) throws -> R) -> Observable<[R]> {
        return map { collection -> [R] in
            return try collection.map(transform)
        }
    }
    
    func flatMapMany<O>(_ selector: @escaping (Element.Element) throws -> O) -> Observable<[O.Element]> where O: ObservableType {
        return flatMap { collection -> Observable<[O.Element]> in
            let new = try collection.map(selector)
            return Observable.zip(new)
        }
    }
}
