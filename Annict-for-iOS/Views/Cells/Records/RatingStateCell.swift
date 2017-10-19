//
//  RatingStateCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/05/31.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

protocol RatingStateCellDelegate {
    func changedSelectedRatingState(state: PortannictRatingState?)
}

class RatingStateCell: UITableViewCell {
    
    var delegate: RatingStateCellDelegate?
    
    @IBOutlet weak var segmentedControl: UnselectedSegmentedControl!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            segmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
            segmentedControl.tintColor = UIColor(hex: 0x4A4A4A)
        }
    }
    
    @IBAction func selectedSegmentedControl(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            sender.tintColor = PortannictRatingState.bad.color
            delegate?.changedSelectedRatingState(state: .bad)
        case 1:
            sender.tintColor = PortannictRatingState.average.color
            delegate?.changedSelectedRatingState(state: .average)
        case 2:
            sender.tintColor = PortannictRatingState.good.color
            delegate?.changedSelectedRatingState(state: .good)
        case 3:
            sender.tintColor = PortannictRatingState.great.color
            delegate?.changedSelectedRatingState(state: .great)
        default:
            sender.tintColor = UIColor(hex: 0x4A4A4A)
            delegate?.changedSelectedRatingState(state: nil)
        }
    }
}
