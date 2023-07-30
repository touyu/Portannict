//
//  RootTabView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/11.
//

import SwiftUI
import ComposableArchitecture

struct RootTabState: Equatable {
    var currentIndex = 0
    var homeState = HomeState()
    var profileState = ProfileState()
}

enum RootTabAction: Equatable {
    case updateIndex(Int)
    case home(HomeAction)
    case profile(ProfileAction)
}

struct RootTabEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
}

let rootTabReducer = Reducer<RootTabState, RootTabAction, RootTabEnvironment>.combine(
    homeReducer.pullback(state: \.homeState,
                         action: /RootTabAction.home,
                         environment: { HomeEnvironment(
                            mainQueue: $0.mainQueue,
                            service: Service(),
                            updateWorkStatus: { _, _ in .none }
                         )}),
    profileReducer.pullback(state: \.profileState,
                            action: /RootTabAction.profile,
                            environment: { ProfileEnvironment(
                                mainQueue: $0.mainQueue
                            )}),
    Reducer { state, action, env in
        switch action {
        case .updateIndex(let index):
            state.currentIndex = index
            return .none
        case .home:
            return .none
        case .profile:
            return .none
        }
    }
)

struct RootTabView: View {
    let store: Store<RootTabState, RootTabAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            TabView(
                selection: viewStore.binding(
                    get: \.currentIndex,
                    send: RootTabAction.updateIndex
                )
            ) {
                HomeView(store: store.scope(state: \.homeState, action: RootTabAction.home))
                    .tabItem {
                        RootTabItem(normalIcon: "house", selectedIcon: "house.fill", selection: viewStore.currentIndex == 0)
                    }
                    .tag(0)
                RecordView()
                    .tabItem {
                        RootTabItem(normalIcon: "pencil.circle", selectedIcon: "pencil.circle.fill", selection: viewStore.currentIndex == 1)
                    }
                    .tag(1)
                SearchView()
                    .tabItem {
                        RootTabItem(normalIcon: "magnifyingglass.circle", selectedIcon: "magnifyingglass.circle.fill", selection: viewStore.currentIndex == 2)
                    }
                    .tag(2)
                ProfileView(store: store.scope(state: \.profileState, action: RootTabAction.profile))
                    .tabItem {
                        RootTabItem(normalIcon: "person", selectedIcon: "person.fill", selection: viewStore.currentIndex == 3)
                    }
                    .tag(3)
            }
            .accentColor(.annictPink)
        }
    }
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
        RootTabView(store: Store(initialState: RootTabState(),
                                 reducer: rootTabReducer,
                                 environment: RootTabEnvironment(
                                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                                 )))
    }
}

extension Color {
    static var annictPink: Color {
        return Color(hex: 0xF85B73)
    }
}
