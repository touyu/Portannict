//
//  AnnictPostRecordsViewController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/13.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

class AnnictPostRecordsViewController: UIViewController {
    
    // 外部から指定
    var episodeID: Int!
    var dismissAction: (() -> Void)?
    
    @IBOutlet dynamic fileprivate weak var tableView: UITableView!
    
    fileprivate var ratingState: RatingState?
    fileprivate var comment: String?
    fileprivate var twitterSharing = false
    fileprivate var facebookSharing = false
    
    fileprivate var textView: UITextView?
    
    // 送信状態かチェック
    fileprivate var posting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTableView()
    }
    
    @IBAction func tapedPostRecordButton(_ sender: UIBarButtonItem) {
        if posting == false {
            self.textView?.resignFirstResponder()
            self.postMeRecord() {
                self.dismissAction?()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func tapedCancelButton(_ sender: UIBarButtonItem) {
        self.textView?.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func initTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.allowsMultipleSelection = true
        self.tableView.register(cellTypes: [RatingStateCell.self, AnnictTextViewCell.self])
    }
    
    fileprivate func postMeRecord(completionHandler:(() -> Void)? = nil) {
        self.posting = true
        let request = AnnictAPI.PostMeRecords(episodeID: episodeID,
                                              comment: comment,
                                              ratingState: ratingState,
                                              shareTwitter:twitterSharing,
                                              shareFacebook: facebookSharing)
        AnnictAPIClient.send(request) { response in
            self.posting = false
            switch response {
            case .success:
                completionHandler?()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension AnnictPostRecordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(with: RatingStateCell.self, for: indexPath)
            cell.delegate = self
            return cell
        case 1:
            return self.getCheckmarkCell(title: "Twitterにシェアする")
        case 2:
            return self.getCheckmarkCell(title: "Facebookにシェアする")
        case 3:
            let cell = tableView.dequeueReusableCell(with: AnnictTextViewCell.self, for: indexPath)
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    fileprivate func getCheckmarkCell(title: String) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "defaultCell")
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textColor = UIColor(hex: 0x1E1E1E)
        cell.textLabel?.text = title
        cell.selectionStyle = .none
        cell.tintColor = .annictPink
        return cell
    }
}

extension AnnictPostRecordsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0, 1, 2:
            return 60
        default:
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        if indexPath.row == 1 {
            // チェックマークを入れる
            cell?.accessoryType = .checkmark
            twitterSharing = true
        } else if indexPath.row == 2 {
            // チェックマークを入れる
            cell?.accessoryType = .checkmark
            facebookSharing = true
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at:indexPath)
        
        if indexPath.row == 1 {
            // チェックマークを外す
            cell?.accessoryType = .none
            twitterSharing = false
        } else if indexPath.row == 2 {
            // チェックマークを外す
            cell?.accessoryType = .none
            facebookSharing = false
        }
    }
}

extension AnnictPostRecordsViewController: RatingStateCellDelegate {
    func changedSelectedRatingState(state: RatingState?) {
        ratingState = state
    }
}

extension AnnictPostRecordsViewController: AnnictTextViewCellDelegate {
    func annictTextViewShouldBeginEditing(_ textView: UITextView) {
        self.textView = textView
        self.tableView.contentSize.height *= 2
    }
    
    func annictTextViewDidChange(_ textView: UITextView) {
        self.comment = textView.text
    }
}
