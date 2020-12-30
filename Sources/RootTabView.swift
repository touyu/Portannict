//
//  RootTabView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/11.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Image(systemName: "house.fill")
                        .font(.system(size: 21))
                }
            Image(systemName: "pencil.circle.fill")
                .tabItem {
                    Image(systemName: "pencil.circle.fill")
                        .font(.system(size: 21))
                }
            Image(systemName: "pencil.circle.fill")
                .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.system(size: 21))
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                        .font(.system(size: 21))
                }
        }
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
            .previewDevice("iPhone 11")

    }
}
