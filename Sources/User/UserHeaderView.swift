//
//  UserHeaderView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/07.
//

import SwiftUI
import KingfisherSwiftUI

struct UserHeaderView: View {
    let user: UserRepresentable

    var body: some View {
        VStack {
            HStack(spacing: 16) {
                KFImage(user.avatarUrl)
                    .resizable()
                    .clipShape(Circle())
                    .foregroundColor(.gray)
                    .frame(width: 80, height: 80)
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.title)
                        .bold()
                    Text("@\(user.name)")
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
            Text(user.description)
                .font(.body)
        }
    }
}

struct UserHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        UserHeaderView(user: UserDummy())
    }
}
