//
//  UnselectedSegmentedControl.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/05/31.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class UnselectedSegmentedControl: UISegmentedControl {
    private var oldValue: Int!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        oldValue = selectedSegmentIndex
        super.touchesBegan(touches, with: event )
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event )
        
        if oldValue == selectedSegmentIndex {
            selectedSegmentIndex = UISegmentedControlNoSegment
            sendActions(for: .valueChanged )
        }
    }
}
