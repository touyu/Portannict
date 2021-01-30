//
//  RootTabView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/11.
//

import SwiftUI
import ComposableArchitecture

struct RootTabView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            HomeView(store: homeStore)
                .tabItem {
                    RootTabItem(normalIcon: "house", selectedIcon: "house.fill", selection: selection == 0)
                }
                .tag(0)
            RecordView()
                .tabItem {
                    RootTabItem(normalIcon: "pencil.circle", selectedIcon: "pencil.circle.fill", selection: selection == 1)
                }
                .tag(1)
            SearchView()
                .tabItem {
                    RootTabItem(normalIcon: "magnifyingglass.circle", selectedIcon: "magnifyingglass.circle.fill", selection: selection == 2)
                }
                .tag(2)
            ProfileView()
                .tabItem {
                    RootTabItem(normalIcon: "person", selectedIcon: "person.fill", selection: selection == 3)
                }
                .tag(3)
        }
        .accentColor(.annictPink)
    }

    private let homeStore = Store(initialState: HomeState(),
                                  reducer: homeReducer,
                                  environment: HomeEnvironment(
                                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                                  )
    )
}

struct RootTabItem: View {
    let normalIcon: String
    let selectedIcon: String
    let selection: Bool

    var body: some View {
        if selection {
            Image(systemName: selectedIcon)
                .font(.system(size: 21))
        } else {
            Image(systemName: normalIcon)
                .font(.system(size: 21))
        }
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
            .previewDevice("iPhone 11")

    }
}

extension Color {
    static var annictPink: Color {
        return Color(hex: 0xF85B73)
    }
}
