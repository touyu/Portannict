//
//  ActivityReviewTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/12/25.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit

final class ActivityReviewTableViewCell: UITableViewCell, StoryboardView {
    typealias Reactor = ActivityReviewTableViewCellReactor

    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func bind(reactor: Reactor) {

    }

}
