//
//  UIImage+Extension.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/04/02.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

extension UIImage {
    
    // 引き延ばした画像を返すメソッド
    class func makeBackgroundImage(state: UIControlState) -> UIImage {
        
//        let baseImage = (state == UIControlState.Highlighted) ? R.image.btn_highlight()! : R.image.btn()!
        let baseImage = #imageLiteral(resourceName: "emptyData_pink_button_background")
        
        // capInsetsは引き延ばす時に引き伸ばしたくない一部分を指定できる
        // ここでは四端5.0×5.0だけそのままのサイズで他を引き延ばすイメージ
        let capInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        
        
        return baseImage.resizableImage(withCapInsets: capInsets, resizingMode: UIImageResizingMode.stretch)
    }
    
    
    //  内部のobjectのサイズとpaddingを指定すれば、imageのwidthを拡大・縮小するメソッド
    func shrinkImageAdjustingObject(before imageSize: CGFloat, objectSize: CGFloat, padding: CGFloat) -> UIImage {
        
        var rectInsets = UIEdgeInsets.zero
        
        
        // imageの端と内部のオブジェクトの端までの距離(片方ずつ)
        let widthBetweenBackgroundAndLabel = (imageSize - objectSize)/2
        
        
        // paddingを考慮してimageをどれくらい拡大・縮小させるか、の指定
        let shrinkWidth = widthBetweenBackgroundAndLabel - padding
        rectInsets = UIEdgeInsets(top: 0, left: -shrinkWidth, bottom: 0, right: -shrinkWidth)
        
        
        return withAlignmentRectInsets(rectInsets)
    }
    
}
