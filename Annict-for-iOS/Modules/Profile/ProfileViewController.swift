//
//  ProfileViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class ProfileViewController: UIViewController, StoryboardView {
    typealias Reactor = ProfileViewReactor

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func bind(reactor: Reactor) {

    }
}
