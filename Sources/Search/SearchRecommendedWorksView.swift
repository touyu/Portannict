//
//  SearchRecommendedWorksView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/11.
//

import SwiftUI
import SwiftUIX

struct SearchRecommendedWorksView: View {
    @StateObject var viewModel: SearchRecommendedWorksViewModel
    @State private var seasonSelection = 1
    @State private var showPicker = false
    @State private var presentation: Presentation?

    enum Presentation: View, Identifiable, Hashable {
        case work(WorkFragment)

        var body: some View {
            switch self {
            case .work(let work):
                WorkView(workID: work.annictId)
            }
        }
    }

    private let seasons = allSeasons()

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(viewModel.state.annictSeason?.title)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Spacer()
                Button(showPicker ? "決定" : "期間を変更する") {
                    withAnimation {
                        showPicker.toggle()
                    }
                    viewModel.action.send(.fetch(seasons[seasonSelection]))
                }
                .foregroundColor(.primary)
            }
            if showPicker {
                Picker(selection: $seasonSelection, label: EmptyView()) {
                    ForEach(seasons.indices) { index in
                        let season = seasons[index]
                        Text(season.title)
                    }
                }
            } else {
                if viewModel.state.recomendedWorks.isEmpty {
                    ActivityIndicator()
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                } else {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(viewModel.state.recomendedWorks.indices, id: \.self) { index in
                            let work = $viewModel.state.recomendedWorks[index]
                            Button(action: {
                                presentation = .work(work.wrappedValue)
                            }, label: {
                                SearchResultView(work: work)
                            })
                            .accentColor(.primary)
                            .sheet(item: $presentation) { $0 }
                        }
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
        .onAppear {
            viewModel.action.send(.fetch(.current))
        }
    }

    private static func allSeasons() -> [AnnictSeason] {
        var item = AnnictSeason.current.next
        var results = [AnnictSeason]()
        for _ in 0..<200 {
            results.append(item)
            item = item.previous
        }
        return results
    }
}

extension WorkFragment: Identifiable, Hashable {
    public func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}
