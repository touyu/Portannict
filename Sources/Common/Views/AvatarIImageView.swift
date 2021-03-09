//
//  AvatarIImageView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/19.
//

import SwiftUI
import KingfisherSwiftUI

struct AvatarImageView: View {
    let url: String?

    init(_ url: String?) {
        self.url = url
    }

    var body: some View {
        KFImage(url)
            .resizable()
            .placeholder {
                Color(hex: 0xE2E2E2)
            }
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .foregroundColor(.gray)
    }
}

struct AvatarImageView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarImageView(UserDummy().avatarUrl)
            .frame(width: 40, height: 40)
            .previewLayout(.fixed(width: 60, height: 60))
        AvatarImageView(nil)
            .frame(width: 40, height: 40)
            .previewLayout(.fixed(width: 60, height: 60))
    }
}
