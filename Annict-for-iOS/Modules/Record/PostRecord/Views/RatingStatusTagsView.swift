//
//  RatingStatusTagsView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/24.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit

final class RatingStatusTagsView: UIView, NibOwnerLoadable {
    
    var selectedRatingState: RatingState? {
        return allButtons.filter { $0.isSelected }.first?.ratingState
    }
    
    @IBOutlet weak var badButton: RecordStatusTagView!
    @IBOutlet weak var averageButton: RecordStatusTagView!
    @IBOutlet weak var goodButton: RecordStatusTagView!
    @IBOutlet weak var greatButton: RecordStatusTagView!
    
    var allButtons: [RecordStatusTagView] {
        return [badButton, averageButton, goodButton, greatButton]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        loadNib()
        
        badButton.configure(ratingState: .bad)
        averageButton.configure(ratingState: .average)
        goodButton.configure(ratingState: .good)
        greatButton.configure(ratingState: .great)
        
        for button in allButtons {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapedButton(_:)))
            button.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc private func tapedButton(_ sender: UITapGestureRecognizer) {
        Taptic.run(.impact(.medium))
        
        guard let button = sender.view as? RecordStatusTagView else { return }
        button.isSelected.toggle()
        
        allButtons.filter { $0 != button }
            .forEach {
                $0.isSelected = false
            }
    }
}
