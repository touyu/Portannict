//
//  WorkHeaderTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/19.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import SQLite

final class WorkHeaderTableViewCell: UITableViewCell {

    @IBOutlet private weak var blurWorkImageView: UIImageView!
    @IBOutlet private weak var workImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var statusButton: WorkStatusButton!

    var didTapButton: (() -> Void)?
    var didTapDetail: (() -> Void)?
    weak var delegate: WorkStatusButtonDelegate? {
        didSet {
            statusButton.delegate = delegate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        workImageView.layer.cornerRadius = 16
        workImageView.layer.masksToBounds = true
        
        blurWorkImageView.layer.masksToBounds = true
        blurWorkImageView.bk.addBlur(blurRadius: 24, colorTint: .white, colorTintAlpha: 0.2)
        statusButton.roundedRectangleFilter()
    }
    
    func configure(work: MinimumWork) {
        workImageView.setImage(workID: work.annictId)
        blurWorkImageView.setImage(workID: work.annictId)
//        workImageView.setImage(url: work.image?.url)
//        blurWorkImageView.setImage(url: work.image?.url)
        titleLabel.text = work.title
        statusButton.configure(status: work.viewerStatusState ?? .noState)
        statusButton.didTap = didTapButton
        statusButton.didTapDetail = didTapDetail
    }
}

extension UIImageView {
    func setImage(workID: Int) {
        let statement = try! SQLiteManager.shared.db.prepare("select * from relations where annict_id = \(workID)")
        let kitsuID = statement.map { $0[3] as! String }.first ?? ""
        setImage(url: URL(string: "https://media.kitsu.io/anime/poster_images/\(kitsuID)/large.jpg")!)
    }
}

final class SQLiteManager {
    static let shared = SQLiteManager()

    let db: SQLite.Connection

    private init() {
        do {
            let path = Bundle.main.path( forResource: "annict-image", ofType: "sqlite" )!
            db = try SQLite.Connection(path)
        } catch {
            fatalError()
        }
    }


}
