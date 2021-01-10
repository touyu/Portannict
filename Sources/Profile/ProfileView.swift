//
//  ProfileView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/11.
//

import SwiftUI
import KingfisherSwiftUI

struct ProfileView: View {
    typealias Viewer = GetViewerQuery.Data.Viewer

    @State var viewer: Viewer?
    @State private var selectorIndex = 0
    @EnvironmentObject var session: LoginSession

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                if let viewer = viewer {
                    UserHeaderView(user: viewer)
                        .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
                    VStack(alignment: .leading, spacing: 24) {
                        Picker("", selection: $selectorIndex) {
                            Text("ライブラリ")
                                .tag(0)
                            Text("アクティビティ")
                                .tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
                        switch selectorIndex {
                        case 0:
                            libraryView(viewer: viewer)
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
            fetch()
        }
    }

    func libraryView(viewer: Viewer) -> some View {
        Group {
            LibraryWorksView(status: .watching, count: viewer.watchingCount)
            LibraryWorksView(status: .wannaWatch, count: viewer.wannaWatchCount)
            LibraryWorksView(status: .watched, count: viewer.watchedCount)
            LibraryWorksView(status: .onHold, count: viewer.onHoldCount)
            LibraryWorksView(status: .stopWatching, count: viewer.stopWatchingCount)
        }
    }

    func fetch() {
        Network.shared.apollo.fetch(query: GetViewerQuery()) { result in
            switch result {
            case .success(let data):
                viewer = data.data?.viewer
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewer: .init(id: "",
                                  annictId: 0,
                                  name: "touyu",
                                  username: "touyu",
                                  avatarUrl: "https://api-assets.annict.com/shrine/profile/5482/image/master-70884f30052922f4f758e6eb69dc6985.jpg",
                                  description: "「Portannict」というAnnictのクライアントアプリ作ってます。",
                                  wannaWatchCount: 20,
                                  watchingCount: 120,
                                  watchedCount: 420,
                                  onHoldCount: 10,
                                  stopWatchingCount: 4))
            .preferredColorScheme(.dark)
    }
}

