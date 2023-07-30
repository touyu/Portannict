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

    init(user: UserRepresentable) {
        self.user = user
    }

    private var isSettiingHidden = false
    @State private var showingSetting = false

    var body: some View {
        VStack(alignment: .leading) {
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
                        .lineLimit(1)
                    Text("@\(user.name)")
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                Spacer()
                if !isSettiingHidden {
                    Button(action: {
                        showingSetting = true
                    }, label: {
                        Image(systemName: "gearshape")
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                    })
                }
            }
            .padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
            Text(user.description)
                .font(.body)
        }
//        .sheet(isPresented: $showingSetting) {
//            SettingView()
//        }
    }

    func hideSettingButton() -> UserHeaderView {
        var result = self
        result.isSettiingHidden = true
        return result
    }
}

struct UserHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        UserHeaderView(user: UserDummy())
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 375, height: 200))
        UserHeaderView(user: UserDummy())
            .hideSettingButton()
            .previewLayout(.fixed(width: 375, height: 200))
    }
}
