//
//  UserRepresentable.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/07.
//

import Foundation

protocol UserRepresentable {
    var name: String { get }
    var username: String { get }
    var description: String { get }
    var avatarUrl: String? { get }
}

struct UserDummy: UserRepresentable {
    var name = "touyu"
    var username = "touyu"
    var description = "「Portannict」というAnnictのクライアントアプリ作ってます。"
    var avatarUrl: String? = "https://api-assets.annict.com/shrine/profile/5482/image/master-70884f30052922f4f758e6eb69dc6985.jpg"
}

extension GetViewerQuery.Data.Viewer: UserRepresentable { }

extension UserFragment: UserRepresentable { }
