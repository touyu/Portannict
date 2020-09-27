//
//  ProfileView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/11.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.title)
                            .bold()
                        Text("@username")
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.init(top: 20, leading: 20, bottom: 20, trailing: 20))
                Text("「Portannict」というAnnictのクライアントアプリを作っています。")
                    .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))

                LazyVStack(alignment: .leading) {
                    ForEach(0..<100) { i in
                        Text("\(i)")
                    }
                    .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

