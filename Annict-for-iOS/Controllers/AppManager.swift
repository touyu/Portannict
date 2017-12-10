//
//  AppManager.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/12/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

struct AppManager {
    // ユーザー情報を取得して、UDに保存する
    static func fetchUserDataAndSave(completionHandler: (() -> Void)? = nil) {
        AnnictGraphQLClient.request(query: GetViewerQuery()) { result, error in
            if let error = error {
                print(error)
                return
            }
            guard let viewer = result?.data?.viewer else { return }
            AnnictConsts.userData = viewer
            completionHandler?()
        }
    }
}
