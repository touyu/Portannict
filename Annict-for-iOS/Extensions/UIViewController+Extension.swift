//
//  Storyboard+Extension.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

protocol StoryBoardInstantiatable {}
extension UIViewController: StoryBoardInstantiatable {}

extension StoryBoardInstantiatable where Self: UIViewController {
    static func instantiate(withStoryboard storyboard: String) -> Self {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! Self
    }
    
    static func instantiate(withStoryboard storyboard: AnnictStoryboard) -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! Self
    }
}

enum AnnictStoryboard: String {
    case annictMeWorks  = "AnnictMeWorks"
    case annictWorks    = "AnnictWorks"
    case login          = "Login"
    case setting        = "Setting"
    case annictActivities = "AnnictActivities"
    case profile        = "Profile"
}
