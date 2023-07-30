//
//  ProfileHeaderView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/03/09.
//

import SwiftUI
import KingfisherSwiftUI
import ComposableArchitecture

struct ProfileHeaderView: View {
    let store: Store<ProfileState, ProfileAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            if let viewer = viewStore.viewer {
                VStack(alignment: .leading) {
                    HStack(spacing: 16) {
                        KFImage(viewer.avatarUrl)
                            .resizable()
                            .clipShape(Circle())
                            .foregroundColor(.gray)
                            .frame(width: 80, height: 80)
                        VStack(alignment: .leading) {
                            Text(viewer.name)
                                .font(.title)
                                .bold()
                                .lineLimit(1)
                            Text("@\(viewer.name)")
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                        }
                        Spacer()
                        Button(action: {
                            viewStore.send(.settingButtonTapped)
                        }, label: {
                            Image(systemName: "gearshape")
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                        })
                    }
                    .padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
                    Text(viewer.description)
                        .font(.body)
                }
            }
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(store: Store(initialState: ProfileState(viewer: .dummy),
                                       reducer: profileReducer,
                                       environment: ProfileEnvironment(
                                        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                                       ))
        )
        .preferredColorScheme(.dark)
        .previewLayout(.fixed(width: 375, height: 200))
    }
}
