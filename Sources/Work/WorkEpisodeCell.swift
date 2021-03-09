//
//  WorkEpisodeCell.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/17.
//

import SwiftUI
import ComposableArchitecture
import Apollo

struct WorkEpisodeCellState: Equatable, Identifiable {
    let episode: EpisodeFragment
    var isPresented: Bool = false

    var id: GraphQLID {
        return episode.id
    }
}

enum WorkEpisodeCellAction: Equatable {
    case setSheet(isPresented: Bool)
}

struct WorkEpisodeCellEnvironment {
    
}

let workEpisodeCellReducer = Reducer<WorkEpisodeCellState, WorkEpisodeCellAction, WorkEpisodeCellEnvironment> { state, action, env in
    switch action {
    case .setSheet(isPresented: let isPresented):
        state.isPresented = isPresented
        return .none
    }
}

struct WorkEpisodeCell: View {
    let store: Store<WorkEpisodeCellState, WorkEpisodeCellAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            Button(action: {
                viewStore.send(.setSheet(isPresented: true))
            }, label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewStore.episode.numberText ?? "Unknown")
                            .font(.system(size: 14))
                        Text(viewStore.episode.title ?? "Unknown")
                            .font(.system(size: 16))
                    }
                    Spacer()
                    Text("\(viewStore.episode.viewerRecordsCount)")
                        .frame(height: 20)
                        .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                        .background(Color.secondarySystemBackground)
                        .cornerRadius(18)
                }
                .foregroundColor(.primary)
            })
            .sheet(isPresented: viewStore.binding(
                get: \.isPresented,
                send: WorkEpisodeCellAction.setSheet(isPresented:)
            )) {
                EpisodeView(episode: viewStore.episode)
            }
        }
    }
}

struct WorkEpisodeCell_Previews: PreviewProvider {
    static var previews: some View {
        WorkEpisodeCell(store: Store(initialState: WorkEpisodeCellState(episode: .init(id: "", annictId: 0, viewerRecordsCount: 0)),
                                     reducer: workEpisodeCellReducer,
                                     environment: WorkEpisodeCellEnvironment()))
    }
}
