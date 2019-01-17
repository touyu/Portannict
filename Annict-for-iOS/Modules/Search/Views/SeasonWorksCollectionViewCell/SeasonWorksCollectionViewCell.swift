//
//  SeasonWorksCollectionViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/01/18.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit

final class SeasonWorksCollectionViewCell: UICollectionViewCell, StoryboardView {
    typealias Reactor = SeasonWorksCollectionViewCellReactor
    
    var disposeBag = DisposeBag()

    @IBOutlet private weak var titleLabel: UILabel!
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())   // Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = false
        collectionView.isScrollEnabled = false
        collectionView.bounds.size = CGSize(width: 412, height: 270)
        collectionView.frame.origin = CGPoint(x: 18, y: 18)
        collectionView.backgroundColor = .clear
        collectionView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        collectionView.transform = CGAffineTransform(rotationAngle: -(.pi / 6))
        collectionView.register(cellTypes: SeasonWorkCollectionViewCell.self)
        contentView.insertSubview(collectionView, at: 0)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(hex: 0x1c1c1c)
        titleLabel.textColor = .white
        
        layer.cornerRadius = 8
        layer.borderColor = UIColor(hex: 0xe6e6e6).cgColor
        layer.borderWidth = 0.4
    }
    
    func bind(reactor: Reactor) {
        reactor.action.onNext(.fetch)
        
        reactor.state.map { $0.section }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] section in
                self?.titleLabel.text = section.title
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.works }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] section in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func setContentOffsetY(_ offset: CGFloat) {
        collectionView.contentOffset.y = offset
    }
}

extension SeasonWorksCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let reactor = reactor else { return 0 }
        return reactor.currentState.works.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: SeasonWorkCollectionViewCell.self, for: indexPath)
        guard let reactor = reactor else { return cell }
        cell.configure(url: reactor.currentState.works[indexPath.item].image?.twitterAvatarUrl)
        return cell
    }
}

extension SeasonWorksCollectionViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

struct Season {
    enum Name: String {
        case spring = "spring"
        case summer = "summer"
        case autumn = "autumn"
        case winter = "winter"
        
        var localizedText: String {
            switch self {
            case .spring:
                return "春"
            case .summer:
                return "夏"
            case .autumn:
                return "秋"
            case .winter:
                return "冬"
            }
        }
    }
    let name: Name
    let year: Int
    
    var value: String {
        return "\(year)-\(name.rawValue)"
    }
    
    static var currentName: Name {
        switch Date().month {
        case 4, 5, 6:
            return .spring
        case 7, 8, 9:
            return .summer
        case 10, 11, 12:
            return .autumn
        case 1, 2, 3:
            return .winter
        default:
            return .spring
        }
    }
    
    static var current: Season {
        return Season(name: currentName, year: Date().year)
    }
    
    func next() -> Season {
        var name = self.name
        var year = self.year
        
        switch name {
        case .spring:
            name = .summer
        case .summer:
            name = .autumn
        case .autumn:
            name = .winter
            year += 1
        case .winter:
            name = .spring
        }
        return Season(name: name, year: year)
    }
    
    func previous(_ num: Int = 1) -> Season {
        var name = self.name
        var year = self.year
        
        switch name {
        case .spring:
            name = .winter
        case .summer:
            name = .spring
        case .autumn:
            name = .summer
        case .winter:
            name = .autumn
            year -= 1
        }
        
        if num == 1 {
            return Season(name: name, year: year)
        } else {
            return Season(name: name, year: year).previous(num - 1)
        }
    }
}

extension Date {
    var year: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return Int(dateFormatter.string(from: self))!
    }
    
    var month: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return Int(dateFormatter.string(from: self))!
    }
}
