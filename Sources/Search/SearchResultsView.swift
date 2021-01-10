//
//  SearchResultsView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/11.
//

import SwiftUI
import KingfisherSwiftUI

struct SearchResultsView: View {
    let title: String
    let works: [WorkFragment]

    init(title: String, works: [WorkFragment]) {
        self.title = title
        self.works = works
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(title)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
            }
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(works.indices, id: \.self) { index in
                    let work = works[index]
                    SearchResultView(work: work)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(title: "検索結果", works: Array(repeating: .dummy, count: 4))
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 370, height: 600))
    }
}

struct SearchResultView: View {
    let work: WorkFragment

    @State private var showingActionSheet = false

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            KFImage(work.annictId)
                .resizable()
                .placeholder {
                    let placeholder = Text("No Image")
                        .foregroundColor(.systemGray)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                    Color(.lightGray)
                        .overlay(placeholder)
                }
                .aspectRatio(3/4, contentMode: .fit)
                .frame(width: 60)
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 8) {
                Text(work.title)
                    .fontWeight(.semibold)

                Text(work.media.localizedText)
                    .font(.system(size: 12))
                    .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 8))
                    .background(Color(.tertiarySystemBackground))
                    .cornerRadius(4)

                Button(action: {
                    showingActionSheet = true
                }, label: {
                    HStack(alignment: .center, spacing: 8) {
                        Text(viewerStatusStateTitle(state: work.viewerStatusState))
                            .font(.system(size: 13))
                            .foregroundColor(work.viewerStatusState != .noState ? .white : .primary)
                        Image(systemName: .arrowtriangleDownFill)
                            .font(.system(size: 8))
                            .foregroundColor(work.viewerStatusState != .noState ? .white : .primary)
                    }
                })
                .frame(height: 32)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .background(work.viewerStatusState != .noState ? .blue : Color(.tertiarySystemBackground))
                .cornerRadius(16)
                .actionSheet(isPresented: $showingActionSheet) {
                    var buttons = StatusState.allCases[0...4]
                        .map { state in
                            return ActionSheet.Button.default(Text(state.title)) {
//                                selectStateAction?(state)
                            }
                        }
                    buttons.append(.cancel())
                    return ActionSheet(title: Text("ステータスを変更"), buttons: buttons)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }

    private func viewerStatusStateTitle(state: StatusState?) -> String {
        if let title = state?.title, !title.isEmpty {
            return title
        }
        return "ステータスを変更"
    }
}
