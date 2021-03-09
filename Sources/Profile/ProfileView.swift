//
//  ProfileView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/11.
//

import SwiftUI
import KingfisherSwiftUI
import ComposableArchitecture

extension GetViewerQuery.Data.Viewer: Equatable { }

struct ProfileState: Equatable {
    enum Presentation: Identifiable, Hashable {
        case setting
        case work(Int)
    }

    var viewer: GetViewerQuery.Data.Viewer?
    var curerntIndex: Int = 0
    var settingState: SettingState?
    var libraryWorksStates: [LibraryWorksState] = []
    var workState: WorkState?
    var presentation: Presentation?
}

enum ProfileAction: Equatable {
    case fetch
    case updateIndex(Int)
    case settingButtonTapped
    case setPresentation(ProfileState.Presentation?)

    case setViewer(Result<GetViewerQuery.Data.Viewer, APIError>)

    case setting(SettingAction)
    case work(WorkAction)
    case libraryWorks(index: Int, action: LibraryWorksAction)
}

struct ProfileEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
}

let profileReducer = Reducer<ProfileState, ProfileAction, ProfileEnvironment>.combine(
    settingReducer
        .optional()
        .pullback(state: \.settingState,
                  action: /ProfileAction.setting,
                  environment: { _ in SettingEnvironment() }),
    workReducer
        .optional()
        .pullback(state: \.workState,
                  action: /ProfileAction.work,
                  environment: { WorkEnvironment(
                    mainQueue: $0.mainQueue
                  )}),
    libraryWorksReducer
        .forEach(state: \.libraryWorksStates,
                 action: /ProfileAction.libraryWorks(index:action:),
                 environment: { LibraryWorksEnvironment(
                    mainQueue: $0.mainQueue
                 )}),
    Reducer { state, action, env in
        struct RequestId: Hashable {}

        switch action {
        case .fetch:
            return APIClient.shared.fetchEffect(query: GetViewerQuery())
                .compactMap { $0.viewer }
                .receive(on: env.mainQueue)
                .catchToEffect()
                .map(ProfileAction.setViewer)
                .cancellable(id: RequestId())
        case .updateIndex(let index):
            state.curerntIndex = index
            return .none
        case .settingButtonTapped:
            return Effect(value: .setPresentation(.setting))
        case .setViewer(.success(let viewer)):
            state.viewer = viewer
            state.libraryWorksStates = [
                .init(status: .watching, count: viewer.watchingCount),
                .init(status: .wannaWatch, count: viewer.wannaWatchCount),
                .init(status: .watched, count: viewer.watchedCount),
                .init(status: .onHold, count: viewer.onHoldCount),
                .init(status: .stopWatching, count: viewer.stopWatchingCount)
            ]
            return .none
        case .setViewer(.failure(let error)):
            return .none
        case .setPresentation(let presentation):
            switch presentation {
            case .setting:
                state.settingState = SettingState()
            case .work(let id):
                state.workState = WorkState(workID: id)
            default:
                break
            }
            state.presentation = presentation
            return .none
        case .setting(let settingActiion):
            switch settingActiion {
            case .logout:
                return Effect(value: .setPresentation(nil))
            }
        case .work:
            return .none
        case .libraryWorks(index: let index, action: let libraryWorksAction):
            switch libraryWorksAction {
            case .workTapped(let childIndex):
                let workID = state.libraryWorksStates[index].works[childIndex].annictId
                return Effect(value: .setPresentation(.work(workID)))
            default:
                return .none
            }
        }
    }
)

struct ProfileView: View {
    let store: Store<ProfileState, ProfileAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    if let viewer = viewStore.viewer {
                        ProfileHeaderView(store: store)
                            .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
                        VStack(alignment: .leading, spacing: 24) {
                            Picker("", selection: viewStore.binding(
                                    get: \.curerntIndex,
                                    send: ProfileAction.updateIndex)
                            ) {
                                Text("ライブラリ")
                                    .tag(0)
                                Text("アクティビティ")
                                    .tag(1)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
                            switch viewStore.curerntIndex {
                            case 0:
                                ForEachStore(
                                    store.scope(state: \.libraryWorksStates,
                                                action: ProfileAction.libraryWorks(index:action:))
                                ) { childStore in
                                    LibraryWorksView(store: childStore)
                                }
                            default:
                                Text("アクティビティ")
                            }
                        }
                        .padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
                    } else {
                        Text("Loading")
                    }
                }
            }
            .onAppear {
                viewStore.send(.fetch)
            }
            .sheet(item: viewStore.binding(
                get: \.presentation,
                send: ProfileAction.setPresentation
            )) { p in
                switch p {
                case .setting:
                    IfLetStore(
                        store.scope(state: \.settingState,
                                    action: ProfileAction.setting),
                        then: SettingView.init(store:)
                    )
                case .work:
                    IfLetStore(
                        store.scope(state: \.workState,
                                    action: ProfileAction.work),
                        then: WorkView.init(store:)
                    )
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(store: Store(initialState: ProfileState(viewer: .dummy),
                                 reducer: profileReducer,
                                 environment: ProfileEnvironment(
                                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                                 ))
        )

        ProfileView(store: Store(initialState: ProfileState(),
                                 reducer: profileReducer,
                                 environment: ProfileEnvironment(
                                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                                 ))
        )
    }
}

extension GetViewerQuery.Data.Viewer {
    static var dummy: Self {
        GetViewerQuery.Data.Viewer(id: "",
                                   annictId: 0,
                                   name: "touyu",
                                   username: "touyu",
                                   avatarUrl: "https://api-assets.annict.com/shrine/profile/5482/image/master-70884f30052922f4f758e6eb69dc6985.jpg",
                                   description: "「Portannict」というAnnictのクライアントアプリ作ってます。",
                                   wannaWatchCount: 20,
                                   watchingCount: 120,
                                   watchedCount: 420,
                                   onHoldCount: 10,
                                   stopWatchingCount: 4)
    }
}
