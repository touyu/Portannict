//
//  QuoteWorkView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/03/10.
//

import SwiftUI
import ComposableArchitecture

struct QuoteWorkState: Equatable {
    let work: WorkFragment
    let episode: EpisodeFragment
    var isExpanded = false
}

enum QuoteWorkAction: Equatable {
    case toggle
    case workButtonTapped
    case episodeButtonTapped
}

struct QuoteWorkEnvironment {

}

let quoteWorkReducer = Reducer<QuoteWorkState, QuoteWorkAction, QuoteWorkEnvironment> { state, action, env in
    switch action {
    case .toggle:
        state.isExpanded.toggle()
        return .none
    case .workButtonTapped:
        return .none
    case .episodeButtonTapped:
        return .none
    }
}

struct QuoteWorkView: View {
    let store: Store<QuoteWorkState, QuoteWorkAction>

    @Namespace private var namespace

    var body: some View {
        WithViewStore(store) { viewStore in
            Button(action: {
                withAnimation(.easeOut(duration: 0.35)) {
                    viewStore.send(.toggle)
                }
            }, label: {
                if viewStore.isExpanded {
                    QuoteWorkExpandedView(store: store, namespace: namespace)
                } else {
                    QuoteWorkNormalView(store: store, namespace: namespace)
                }
            })
        }
    }
}

struct QuoteWorkView_Previews: PreviewProvider {
    @Namespace private static var namespace

    static var previews: some View {
        QuoteWorkView(store: Store(initialState: QuoteWorkState(work: .dummy, episode: .dummy),
                                   reducer: quoteWorkReducer,
                                   environment: QuoteWorkEnvironment()))
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}


struct QuoteWorkNormalView: View {
    let store: Store<QuoteWorkState, QuoteWorkAction>
    let namespace: Namespace.ID

    var body: some View {
        WithViewStore(store) { viewStore in
            HStack(alignment: .center, spacing: 8) {
                WorkImage(workID: viewStore.work.annictId)
                    .matchedGeometryEffect(id: "WorkImage", in: namespace, anchor: .topLeading)
                    .aspectRatio(3/4, contentMode: .fit)
                    .frame(height: 80)
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewStore.work.title)
                        .lineLimit(2)
                        .matchedGeometryEffect(id: "Title", in: namespace, anchor: .leading)
                        .font(.system(size: 14))
                        .foregroundColor(Color.primary)
                    if let epi = viewStore.episode {
                        Text("\(epi.numberText ?? "") \(epi.title ?? "")")
                            .lineLimit(2)
                            .matchedGeometryEffect(id: "Episode", in: namespace)
                            .font(.system(size: 11))
                            .foregroundColor(Color.primary)
                    }
                }
                Spacer()
            }
            .background(Color(.quaternarySystemFill))
            .cornerRadius(8)
        }
    }
}

struct QuoteWorkNormalView_Previews: PreviewProvider {
    @Namespace private static var namespace

    static var previews: some View {
        QuoteWorkNormalView(store: Store(initialState: QuoteWorkState(work: .dummy, episode: .dummy),
                                   reducer: quoteWorkReducer,
                                   environment: QuoteWorkEnvironment()),
                              namespace: namespace)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}

struct QuoteWorkExpandedView: View {
    let store: Store<QuoteWorkState, QuoteWorkAction>
    let namespace: Namespace.ID

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top, spacing: 8) {
                    WorkImage(workID: viewStore.work.annictId)
                        .matchedGeometryEffect(id: "WorkImage", in: namespace, anchor: .topLeading)
                        .aspectRatio(3/4, contentMode: .fit)
                        .cornerRadius(8)
                        .frame(height: 80)
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewStore.work.title)
                            .fixedSize(horizontal: false, vertical: true)
                            .matchedGeometryEffect(id: "Title", in: namespace, anchor: .leading)
                            .font(.system(size: 14))
                            .foregroundColor(Color.primary)

                        if let epi = viewStore.episode {
                            Text("\(epi.numberText ?? "") \(epi.title ?? "")")
                                .fixedSize(horizontal: false, vertical: true)
                                .matchedGeometryEffect(id: "Episode", in: namespace)
                                .font(.system(size: 11))
                                .foregroundColor(Color.primary)
                        }
                    }
                }

                Button(viewerStatusStateTitle(state: viewStore.work.viewerStatusState)) {
                    //                    showingActionSheet = true
                }
                .font(.system(size: 14))
                .foregroundColor(viewStore.work.viewerStatusState != .noState ? .white : .primary)
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(viewStore.work.viewerStatusState != .noState ? .blue : Color(.tertiarySystemBackground))
                .cornerRadius(20)

                Button("作品を開く") {
                    viewStore.send(.workButtonTapped)
                }
                .font(.system(size: 14))
                .foregroundColor(.primary)
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color(.tertiarySystemBackground))
                .cornerRadius(20)

                Button("エピソードを開く") {
                    viewStore.send(.episodeButtonTapped)
                }
                .font(.system(size: 14))
                .foregroundColor(.primary)
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color(.tertiarySystemBackground))
                .cornerRadius(20)
            }
            .padding(8)
            .background(Color(.quaternarySystemFill))
            .cornerRadius(8)
        }
    }

    private func viewerStatusStateTitle(state: StatusState?) -> String {
        if let title = state?.title, !title.isEmpty {
            return title
        }
        return "ステータスを変更"
    }
}

struct QuoteWorkExpandedView_Previews: PreviewProvider {
    @Namespace private static var namespace

    static var previews: some View {
        QuoteWorkExpandedView(store: Store(initialState: QuoteWorkState(work: .dummy, episode: .dummy),
                                   reducer: quoteWorkReducer,
                                   environment: QuoteWorkEnvironment()),
                              namespace: namespace)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
