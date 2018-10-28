//
//  RecordViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class RecordViewController: UIViewController, StoryboardView {
    typealias Reactor = RecordViewReactor

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func bind(reactor: Reactor) {

    }
}
