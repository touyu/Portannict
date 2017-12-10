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
            if !isRegistering {
                guard let userData = AnnictConsts.userData?.snapshot else { return }
                self.db.collection("Users").addDocument(data: userData) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
    }
    
    func checkRegsiter(completionHandler: @escaping ((Bool) -> Void)) {
        fetchViewer() { result in
            switch result {
            case .success(let snapshot):
                guard let snapshot = snapshot else { return }
                if snapshot.documents.count == 0 {
                    completionHandler(false)
                } else {
                    completionHandler(true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchViewer(completionHandler: ((FirestoreClientResult) -> Void)?) {
        guard let userID = AnnictConsts.userID else { return }
        fetchUser(id: userID) { result in
            switch result {
            case .success(let snapshot):
                completionHandler?(.success(snapshot))
            case .failure(let error):
                completionHandler?(.failure(error))
            }
        }
    }
    
    private func fetchUser(id: Int, completionHandler: ((FirestoreClientResult) -> Void)?) {
        db.collection("Users").whereField("annictId", isEqualTo: id).getDocuments() { (snapshot, error) in
            if let error = error {
                completionHandler?(.failure(error))
            } else {
                completionHandler?(.success(snapshot))
            }
        }
    }
}
