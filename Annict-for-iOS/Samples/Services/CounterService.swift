//
//  CounterService.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/22.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import RxSwift

enum CounterEvent {
    case increase10
}

protocol CounterServiceType {
    var event: PublishSubject<CounterEvent> { get }
    func increase10(num: Int) -> Observable<Int>
}

final class CounterService: BaseService, CounterServiceType {
    let event = PublishSubject<CounterEvent>()
    
    func increase10(num: Int) -> Observable<Int> {
        return Observable.just(num + 10)
            .do(onNext: { [weak self] _ in
                self?.event.onNext(.increase10)
            })
    }
}
