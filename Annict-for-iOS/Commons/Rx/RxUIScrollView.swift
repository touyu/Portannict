//
//  RxUIScrollView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import RxSwift

extension Reactive where Base: UIScrollView {
    var reachedBottom: Observable<Void> {
        return contentOffset
            .flatMap { [weak base] contentOffset -> Observable<Void> in
                guard let scrollView = base else { return Observable.empty() }
                
                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
                let y = contentOffset.y + scrollView.contentInset.top
                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
                return y > threshold ? Observable.just(()) : Observable.empty()
        }
    }

    var triggeredPagination: Observable<Void> {
        return contentOffset
            .flatMap { [weak base] contentOffset -> Observable<Void> in
                guard let scrollView = base else { return Observable.empty() }

                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
                let y = contentOffset.y + scrollView.contentInset.top
                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight - scrollView.frame.height)
                return y > threshold ? Observable.just(()) : Observable.empty()
        }
    }
}
