//
//  SearchRecomendedWorksView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/10.
//

import SwiftUI
import KingfisherSwiftUI

struct SearchRecomendedWorksView: View {
    let title: String
    let works: [WorkFragment]

    var changeSeasonAction: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(title)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Spacer()
                Button("期間を変更する") {
                    changeSeasonAction?()
                }
                .foregroundColor(.primary)
            }
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 2), spacing: 10) {
                ForEach(works.indices, id: \.self) { index in
                    let work = works[index]
                    SearchRecomendedWorkView(work: work)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }

    func onTapChangeSeasonButton(_ action: @escaping (() -> Void)) -> SearchRecomendedWorksView {
        var result = self
        result.changeSeasonAction = action
        return result
    }
}

struct SearchRecomendedWorksView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRecomendedWorksView(title: "今期", works: Array(repeating: .dummy, count: 4))
            .previewLayout(.fixed(width: 375, height: 600))
    }
}

struct SearchRecomendedWorkView: View {
    let work: WorkFragment

    private let maxWidth: CGFloat = 140
    private let black = Color(hex: 0x222222)
    private var gradient: Gradient {
        Gradient(stops: [Gradient.Stop(color: .clear, location: 0),
                         Gradient.Stop(color: black.opacity(0.8), location: 0.8),
                         Gradient.Stop(color: black, location: 1)])
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottom) {
                KFImage(work.annictId)
                    .resizable()
                    .placeholder {
                        Text("No Image")
                            .foregroundColor(.systemGray)
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                    }
                    .aspectRatio(3/4, contentMode: .fit)
                    .background(Color(.systemGray6))
                Text(work.title)
                    .lineLimit(2)
                    .font(.system(size: 12), weight: .semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .background(LinearGradient(gradient: gradient,
                                               startPoint: .top,
                                               endPoint: .bottom))
            }

            Button(action: {

            }, label: {
                HStack(alignment: .center, spacing: 8) {
                    Text(viewerStatusStateTitle(state: work.viewerStatusState))
                        .font(.system(size: 12))
                        .foregroundColor(work.viewerStatusState != .noState ? .white : .primary)
                    Image(systemName: .arrowtriangleDownFill)
                        .font(.system(size: 8))
                        .foregroundColor(work.viewerStatusState != .noState ? .white : .primary)
                }
            })
            .frame(height: 32)
            .frame(maxWidth: .infinity)
            .background(work.viewerStatusState != .noState ? .blue : Color(.tertiarySystemBackground))
            .cornerRadius(16)
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))

        }
        .background(Color(.quaternarySystemFill))
        .cornerRadius(4)
    }

    private func viewerStatusStateTitle(state: StatusState?) -> String {
        if let title = state?.title, !title.isEmpty {
            return title
        }
        return "ステータスを変更"
    }
}

struct SearchRecomendedWorkView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRecomendedWorkView(work: .dummy)
            .frame(width: 140)
            .previewLayout(.fixed(width: 300, height: 300))
        SearchRecomendedWorkView(work: .dummy2)
            .frame(width: 140)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}

