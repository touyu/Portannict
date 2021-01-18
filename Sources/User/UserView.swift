//
//  UserView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/07.
//

import SwiftUI

struct UserView: View {
    let username: String
    @State private var user: UserFragment?

    init(username: String) {
        self.username = username
    }

    var body: some View {
        VStack {
            if let user = user {
                UserHeaderView(user: user)
                    .hideSettingButton()
                    .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
        }
        .onAppear {
            fetch()
        }
    }

    private func fetch() {
        Network.shared.apollo.fetch(query: GetUserQuery(username: username)) { result in
            switch result {
            case .success(let data):
                user = data.data?.user?.fragments.userFragment
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(username: "touyu")
    }
}
