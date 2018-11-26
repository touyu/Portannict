//
//  UserWorksWithSectionTitleCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/25.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

final class UserWorksWithSectionTitleCell: UITableViewCell {
    typealias Work = GetViewerWorksQuery.Data.Viewer.Work.Edge.Node

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var works: [Work] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        prepareCollectionView()
    }
    
    func prepare(title: String, works: [Work]) {
        self.titleLabel.text = title
        self.works = works
        self.collectionView.reloadData()
    }
    
    private func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellTypes: UserWorkCollectionViewCell.self)
    }
}

extension UserWorksWithSectionTitleCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return works.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: UserWorkCollectionViewCell.self, for: indexPath)
        cell.prepare(work: works[indexPath.item])
        return cell
    }
}

extension UserWorksWithSectionTitleCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
