//
//  QuoteWorkView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/23.
//

import SwiftUI
import KingfisherSwiftUI
import ComposableArchitecture

struct QuoteWorkView2: View {
    @Binding var work: WorkFragment
    let episode: EpisodeFragment?

    @State private var isExpanded: Bool = false
    @State private var isPresentedWorkView: Bool = false
    @State private var showingActionSheet = false
    @Namespace private var namespace

    var selectStateAction: ((StatusState) -> Void)?

    init(work: Binding<WorkFragment>, episode: EpisodeFragment? = nil) {
        self._work = work
        self.episode = episode
    }

    var body: some View {
        Group {
            if isExpanded {
                VStack(alignment: .leading) {
                    HStack(alignment: .top, spacing: 8) {
                        WorkImage(workID: work.annictId)
                            .matchedGeometryEffect(id: "WorkImage", in: namespace, anchor: .topLeading)
                            .aspectRatio(3/4, contentMode: .fit)
                            .cornerRadius(8)
                            .frame(height: 80)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(work.title)
                                .lineLimit(2)
                                .matchedGeometryEffect(id: "Title", in: namespace, anchor: .leading)
                                .font(.system(size: 14))
                                .foregroundColor(Color.primary)

                            if let epi = episode {
                                Text("\(epi.numberText ?? "") \(epi.title ?? "")")
                                    .lineLimit(2)
                                    .matchedGeometryEffect(id: "Episode", in: namespace)
                                    .font(.system(size: 11))
                                    .foregroundColor(Color.primary)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(8)

                    HStack(spacing: 8) {
                        let title = viewerStatusStateTitle(state: work.viewerStatusState)
                        Button(title) {
                            showingActionSheet = true
                        }
                        .font(.system(size: 14))
                        .foregroundColor(work.viewerStatusState != .noState ? .white : .primary)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(work.viewerStatusState != .noState ? .blue : Color(.tertiarySystemBackground))
                        .cornerRadius(20)
                        .actionSheet(isPresented: $showingActionSheet) {
                            var buttons = StatusState.allCases[0...4]
                                .map { state in
                                    return ActionSheet.Button.default(Text(state.title)) {
                                        selectStateAction?(state)
                                        work.viewerStatusState = state
                                    }
                                }
                            buttons.append(.cancel())
                            return ActionSheet(title: Text("ステータスを変更"), buttons: buttons)
                        }

                        Button("詳細を見る") {
                            isPresentedWorkView = true
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.primary)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(Color(.tertiarySystemBackground))
                        .cornerRadius(20)
                        .sheet(isPresented: $isPresentedWorkView) {
                            WorkView(store: Store(initialState: WorkState(workID: work.annictId),
                                                  reducer: workReducer,
                                                  environment: WorkEnvironment(
                                                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                                                  )
                                    )
                            )
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))

                    Spacer()
                        .layoutPriority(1)
                }
                .background(Color(.quaternarySystemFill))
                .cornerRadius(8)
            } else {
                HStack(alignment: .center, spacing: 8) {
                    WorkImage(workID: work.annictId)
                        .matchedGeometryEffect(id: "WorkImage", in: namespace, anchor: .topLeading)
                        .aspectRatio(3/4, contentMode: .fit)
                        .frame(height: 80)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(work.title)
                            .lineLimit(2)
                            .matchedGeometryEffect(id: "Title", in: namespace, anchor: .leading)
                            .font(.system(size: 14))
                            .foregroundColor(Color.primary)
                        if let epi = episode {
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
        .onTapGesture {
            withAnimation(.easeOut(duration: 0.25)) {
                isExpanded.toggle()
            }
        }
    }

    func onSelectState(_ action: @escaping (StatusState) -> Void) -> QuoteWorkView2 {
        var result = self
        result.selectStateAction = action
        return result
    }

    private func viewerStatusStateTitle(state: StatusState?) -> String {
        if let title = state?.title, !title.isEmpty {
            return title
        }
        return "ステータスを変更"
    }
}

struct QuoteWorkView2_Previews: PreviewProvider {
    @Namespace private static var namespace

    static var previews: some View {
        QuoteWorkView2(work: .constant(WorkFragment.dummy))
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/375.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/))
        QuoteWorkView2(work: .constant(WorkFragment.dummy), episode: EpisodeFragment(id: "", annictId: 0, title: "冒険の始まり", numberText: "第1話", viewerRecordsCount: 0))
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/375.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/))
    }
}
