//
//  UIImageView.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/25.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit
import Kingfisher
import SQLite

extension UIImageView {
    func setImage(url: URLConvertible?, completion: ((UIImage?) -> Void)? = nil) {
        let downloader = ImageDownloader.default
        downloader.downloadTimeout = 300
        kf.setImage(with: url?.asURL(),
                    placeholder: UIImage.make(color: UIColor(white: 0.9, alpha: 1)),
                    options: [.transition(.fade(0.4)),
                              .downloader(downloader)],
                    completionHandler: { img, error, _, url in
                        completion?(img)
        })
    }

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
