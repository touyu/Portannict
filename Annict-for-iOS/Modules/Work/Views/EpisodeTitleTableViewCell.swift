//
//  EpisodeTitleTableViewCell.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2019/07/19.
//  Copyright © 2019 Yuto Akiba. All rights reserved.
//

import UIKit
import ReactorKit
import M13Checkbox
import RxSwift

protocol EpisodeTitleTableViewCellDelegate: class {
    func episodeTitleTableViewCell(_ cell: EpisodeTitleTableViewCell, didChangeSelected: Bool)
}

final class EpisodeTitleTableViewCell: UITableViewCell, StoryboardView {
    typealias Reactor = EpisodeTitleTableViewCellReactor

    weak var delegate: EpisodeTitleTableViewCellDelegate?
    var disposeBag = DisposeBag()

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var checkbox: M13Checkbox!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        countLabel.roundedRectangleFilter()
        countLabel.backgroundColor = UIColor(hex: 0xEBEBEB)
        titleLabel.textColor = UIColor(hex: 0x464646)

        checkbox.boxType = .square
        checkbox.animationDuration = 0.2
        checkbox.checkmarkLineWidth = 1.4
        checkbox.boxLineWidth = 1.4
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        countLabel.backgroundColor = UIColor(hex: 0xEBEBEB)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        countLabel.backgroundColor = UIColor(hex: 0xEBEBEB)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
    }

    func bind(reactor: Reactor) {
        checkbox.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [unowned self] in
                Taptic.run(.impact(.medium))
                let isSelected = self.checkbox.checkState == .checked ? true : false
                reactor.action.onNext(.updateIsSelected(isSelected))
                self.delegate?.episodeTitleTableViewCell(self, didChangeSelected: isSelected)
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.episode }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] episode in
                self?.configure(episode: episode)
            })
            .disposed(by: disposeBag)

        reactor.state.map { $0.isSelected }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isSelected in
                print("AAAAAAAAAA")
                self?.checkbox.setCheckState(isSelected ? .checked : .unchecked, animated: false)
            })
            .disposed(by: disposeBag)
    }
    
    private func configure(episode: MinimumEpisode) {
        titleLabel.text = episode.numberAndTitle
        countLabel.text = "\(episode.viewerRecordsCount)"
    }
}
