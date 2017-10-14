//
//  Skeletonable.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/10/14.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

//protocol Skeletonable {
//    func skeletonize()
//    func normalize()
//}
//
//extension Skeletonable where Self: UITableViewCell {
//    func skeletonize() {
//        selectionStyle = .none
//        contentView.subviews.forEach {
//            $0.alpha = 0
//
//            if let view = $0 as? Shimmerable {
//                view.makeShimmerableViews().forEach {
//                    contentView.addSubview($0)
//                }
//            } else {
//                let shimmerableView = ShimmerableView(frame: $0.frame)
//                shimmerableView.layer.masksToBounds = true
//                shimmerableView.layer.cornerRadius = 2
//                contentView.addSubview(shimmerableView)
//            }
//        }
//    }
//
//    func normalize() {
//        selectionStyle = .none
//        contentView.subviews.forEach {
//            if let shimmerableView = $0 as? ShimmerableView {
//                shimmerableView.removeFromSuperview()
//            } else {
//                $0.alpha = 1
//            }
//        }
//    }
//}
//
//private protocol Shimmerable {
//    func makeShimmerableViews() -> [ShimmerableView]
//}
//
//private extension Shimmerable where Self: UILabel {
//    func makeShimmerableViews() -> [ShimmerableView] {
//        let fontSize = font.pointSize
//        let height = frame.size.height
//        var views: [ShimmerableView] = []
//        for i in 0...Int(height/fontSize) {
//            let frame = CGRect(x: self.frame.origin.x,
//                               y: self.frame.origin.y + (fontSize*2*CGFloat(i)),
//                               width: bounds.width,
//                               height: fontSize)
//            let view = ShimmerableView(frame: frame)
//            views.append(view)
//        }
//        return views
//    }
//}
//
//extension UILabel: Shimmerable { }

