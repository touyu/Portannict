//
//  LibraryWorksView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/07.
//

import SwiftUI
import KingfisherSwiftUI
import ComposableArchitecture

extension WorkFragment: Equatable {}

struct LibraryWorksState: Equatable, Identifiable {
    let id = UUID()
    let status: StatusState
    let count: Int
    var works: [WorkFragment] = []
}

enum LibraryWorksAction: Equatable {
    case onAppear

    case setWorks(Result<[WorkFragment], APIError>)
}

struct LibraryWorksEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
}

let libraryWorksReducer = Reducer<LibraryWorksState, LibraryWorksAction, LibraryWorksEnvironment> { state, action, env in
    struct RequestId: Hashable { }

    switch action {
    case .onAppear:
       return APIClient.shared.fetchEffect(query: GetViewerWorksQuery(first: 10, state: state.status))
            .map { $0.viewer?.works?.edges?.compactMap { $0?.node?.fragments.workFragment } ?? [] }
            .catchToEffect()
            .map(LibraryWorksAction.setWorks)
            .cancellable(id: RequestId())
    case .setWorks(.success(let works)):
        state.works = works
        return .none
    case .setWorks(.failure(let error)):
        return .none
    }
}

struct LibraryWorksView: View {
    let store: Store<LibraryWorksState, LibraryWorksAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("\(viewStore.status.title) \(viewStore.count)")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .padding(.leading, 16)
                    Spacer()
                    Text("もっと見る")
                        .font(.system(size: 12))
                        .padding(.trailing, 16)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 12) {
                        if viewStore.works.isEmpty {
                            ForEach(0..<3) { index in
                                Rectangle()
                                    .skeleton(with: true)
                                    .shape(type: .rounded(.radius(8, style: .circular)))
                                    .frame(width: 140, height: 140 * 5/3)
                            }
                        } else {
                            ForEach(viewStore.works.indices, id: \.self) { index in
                                LibraryWorkView(work: viewStore.works[index])
                                    .frame(width: 140, height: 140 * 5/3)
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

struct LibraryWorksView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryWorksView(store: Store(initialState: LibraryWorksState(status: .watching, count: 32),
                                      reducer: libraryWorksReducer,
                                      environment: LibraryWorksEnvironment(
                                        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                                      )))
            .previewLayout(.fixed(width: 375, height: 300))
    }
}

