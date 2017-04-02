//
//  DZNEmptyDataSetHelper.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/04/02.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import DZNEmptyDataSet

enum DZNEmptyDataSetHelperStatus {
    case empty
    case networkError
}

struct DZNEmptyDataSetHelper {
    
    // MARK: - NetworkError
    struct NetworkError {
        private struct Const {
            static var titleString = "ネットワークエラーです"
            static var titleFont = UIFont.systemFont(ofSize: 28, weight: UIFontWeightThin)
            static var buttonTitleString = "リトライ"
            static var buttonTitleFont = UIFont.systemFont(ofSize: 16)
        }
        
        static var title: NSAttributedString {
            return NSAttributedString(
                string: Const.titleString,
                attributes: [
                    NSFontAttributeName: Const.titleFont,
                    NSForegroundColorAttributeName: UIColor.lightGray
                ]
            )
        }
        
        static var buttonTitle: NSAttributedString {
            return NSAttributedString(
                string: Const.buttonTitleString,
                attributes: [
                    NSFontAttributeName: Const.buttonTitleFont,
                    NSForegroundColorAttributeName: UIColor.annictPink
                ]
            )
        }
        
        static private var buttonTitleSize: CGFloat {
            return Const.buttonTitleString.height(withConstrainedWidth: 44, font: Const.buttonTitleFont)
        }
        
        static func buttonBackgroundImage(view: UIView, state: UIControlState) -> UIImage {
            // 引き伸ばされたbackgroundImageとview.bounds.size.widthとの比率。
            // どの機種でもだいたい88%でした
            let ratioViewBoundsWidthAndButton: CGFloat = 0.88
            
            //  引き伸ばされたbackgroundImageのsize
            let defaultSize = view.bounds.size.width * ratioViewBoundsWidthAndButton
            
            //  titleLabelのpadding.お好みで
            let padding: CGFloat = 20
            
            // 背景画像を引き伸ばしてからtitleLabelに合わせてwidthを調節してUIImageを返す
            return UIImage.makeBackgroundImage(state: state).shrinkImageAdjustingObject(before: defaultSize, objectSize: buttonTitleSize, padding: padding)
        }
    }
    
    struct Empty {
        private struct Const {
            static var titleString = "コンテンツがありません"
            static var titleFont = UIFont.systemFont(ofSize: 28, weight: UIFontWeightThin)
            static var buttonTitleString = "リトライ"
            static var buttonTitleFont = UIFont.systemFont(ofSize: 16)
        }
        
        static var title: NSAttributedString {
            return NSAttributedString(
                string: Const.titleString,
                attributes: [
                    NSFontAttributeName: Const.titleFont,
                    NSForegroundColorAttributeName: UIColor.lightGray
                ]
            )
        }
    }
}
