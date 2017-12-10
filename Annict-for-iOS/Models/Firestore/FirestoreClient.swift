//
//  FirestoreClient.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/12/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

import Firebase

enum FirestoreClientResult {
    case success(QuerySnapshot?)
    case failure(Error)
}

struct FirestoreClient {
    let db = Firestore.firestore()
    
    static let shared = FirestoreClient()
    private init() {}
    
    func register() {
        checkRegsiter() { isRegistering in
            // Firestoreへ新規登録
            if !isRegistering {
                guard var data = AnnictConsts.userData?.dictionary else { return }
                data["updatedAtFirestore"] = Date()
                data["createdAtFirestore"] = Date()
                data["isPurchased"] = true
                guard let userID = AnnictConsts.userID else { return }
                self.db.collection("Users").document("user_\(userID)").setData(data, options: SetOptions.merge()) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            } else {
                guard var data = AnnictConsts.userData?.dictionary else { return }
                data["updatedAtFirestore"] = Date()
                guard let userID = AnnictConsts.userID else { return }
                self.db.collection("Users").document("user_\(userID)").updateData(data) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
    }
    
    private func checkRegsiter(completionHandler: @escaping ((_ isRegistering: Bool) -> Void)) {
        guard let userID = AnnictConsts.userID else { return }
        db.collection("Users").whereField("annictId", isEqualTo: userID).exists() { isEmpty in
            completionHandler(!isEmpty)
        }
    }
}

extension Query {
    func exists(completionHandler: @escaping ((_ isEmpty: Bool) -> Void)) {
        getDocuments() { (snapshot, error) in
            if let error = error {
                print(error)
                completionHandler(true)
            } else {
                guard let snapshot = snapshot else {
                    completionHandler(true)
                    return
                }
                if snapshot.documents.count == 0 {
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            }
        }
    }
}

extension GetViewerQuery.Data.Viewer {
    var dictionary: [String: Any] {
        var data = [String: Any]()
        snapshot.forEach { key, value in
            data[key] = value!
        }
        return data
    }
}
