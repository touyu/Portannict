//
//  RxUIViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/23.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import RxSwift

extension Reactive where Base: UIViewController {
    var viewDidLoad: Observable<Void> {
        return sentMessage(#selector(base.viewDidLoad))
            .map { _ in () }
            .share(replay: 1)
    }

    var viewWillAppear: Observable<Void> {
        return sentMessage(#selector(base.viewWillAppear))
            .map { _ in () }
            .share(replay: 1)
    }

    var viewDidLayoutSubviews: Observable<Void> {
        return sentMessage(#selector(base.viewDidLayoutSubviews))
            .map { _ in () }
            .share(replay: 1)
    }

    var viewDidAppear: Observable<Void> {
        return sentMessage(#selector(base.viewDidAppear))
            .map { _ in () }
            .share(replay: 1)
    }

    var viewWillDisappear: Observable<Void> {
        return sentMessage(#selector(base.viewWillDisappear(_:)))
            .map { _ in () }
            .share(replay: 1)
    }
}
