//
//  SettingView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/18.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject private var session: LoginSession
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("バージョン")
                        Spacer()
                        Text(Constants.appVersion)
                            .foregroundColor(.gray)
                    }
                    NavigationLink(destination: LicensesView()) {
                        Text("ライセンス表記")
                    }


                }

                Button(action: {
                    session.accessToken = nil
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("ログアウト")
                        .foregroundColor(.red)
                })
            }
            .navigationTitle("設定")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
