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

extension ObservableType where E: OptionalType {
    func filterNil() -> Observable<E.Wrapped> {
        return self.flatMap { element -> Observable<E.Wrapped> in
            guard let value = element.value else {
                return Observable<E.Wrapped>.empty()
            }
            return Observable<E.Wrapped>.just(value)
        }
    }
}

extension ObservableType where E: Sequence {
    func mapMany<R>(_ transform: @escaping (E.Element) throws -> R) -> Observable<[R]> {
        return map { collection -> [R] in
            return try collection.map(transform)
        }
    }
    
    func flatMapMany<O>(_ selector: @escaping (E.Element) throws -> O) -> Observable<[O.E]> where O: ObservableType {
        return flatMap { collection -> Observable<[O.E]> in
            let new = try collection.map(selector)
            return Observable.zip(new)
        }
    }
}
