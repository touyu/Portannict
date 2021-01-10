//
//  SearchView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/07.
//

import SwiftUI
import SwiftUIX
import KingfisherSwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel = .init()

    @State private var searchText : String = ""
    
    private var results: [WorkFragment] = [.dummy, .dummy, .dummy, .dummy, .dummy]

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    SearchBar("タイトルを入力", text: $searchText)
                    if searchText.isEmpty {
                        SearchRecomendedWorksView2(title: viewModel.state.annictSeason.title,
                                                  works: viewModel.state.recomendedWorks)
                            .onTapChangeSeasonButton {
                                viewModel.action.send(.fetch(viewModel.state.annictSeason.previous))
                            }
                    } else {
                        SearchResultView(works: results)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                }
                .padding(.bottom, 40)
            }
            .navigationBarTitle("Search")
            .onAppear {
                viewModel.action.send(.fetch(.current))
            }
        }
    }
}

struct SearchRecomendedWorksView2: View {
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
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(works.indices, id: \.self) { index in
                    let work = works[index]
                    HStack(spacing: 16) {
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
                            .frame(width: 120, height: 32)
                            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                            .background(work.viewerStatusState != .noState ? .blue : Color(.tertiarySystemBackground))
                            .cornerRadius(16)
                        }
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }

    func onTapChangeSeasonButton(_ action: @escaping (() -> Void)) -> SearchRecomendedWorksView2 {
        var result = self
        result.changeSeasonAction = action
        return result
    }

    private func viewerStatusStateTitle(state: StatusState?) -> String {
        if let title = state?.title, !title.isEmpty {
            return title
        }
        return "ステータスを変更"
    }
}

struct SearchRecomendedWorksView2_Previews: PreviewProvider {
    static var previews: some View {
        SearchRecomendedWorksView2(title: "今期", works: Array(repeating: .dummy, count: 4))
            .previewLayout(.fixed(width: 370, height: 600))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


struct SearchResultView: View {
    let works: [WorkFragment]

    var body: some View {
        VStack(alignment: .leading) {
            Text("検索結果")
            ForEach(works.indices, id: \.self) { index in
                let work = works[index]
                HStack(spacing: 8) {
                    KFImage(work.annictId)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60)
                        .cornerRadius(8)
                    Text(work.title)
                }
            }
        }
    }
}

struct AnnictSeason: Equatable {
    let year: Int
    let season: Season

    static var current: AnnictSeason {
        return .init(year: Date().year, season: .current)
    }

    var next: AnnictSeason {
        var newYear = self.year
        if season == .autumn {
            newYear += 1
        }
        return .init(year: newYear, season: season.next)
    }

    var previous: AnnictSeason {
        var newYear = self.year
        if season == .winter {
            newYear -= 1
        }
        return .init(year: newYear, season: season.previous)
    }

    var id: String {
        return "\(year)-\(season.rawValue)"
    }

    var title: String {
        if self == AnnictSeason.current {
            return "今期"
        }
        switch self {
        case .current:
            return "今期"
        case AnnictSeason.current.next:
            return "来期"
        case AnnictSeason.current.previous:
            return "前期"
        default:
            return "\(year)年 \(season.localizedText)"
        }
    }

    enum Season: String, Equatable {
        case winter
        case spring
        case summer
        case autumn

        static var current: Season {
            switch Date().month {
            case 1...3:
                return .winter
            case 4...6:
                return .spring
            case 7...9:
                return .summer
            case 10...12:
                return .autumn
            default:
                fatalError("Not found season")
            }
        }

        var localizedText: String {
            switch self {
            case .winter:
                return "冬"
            case .spring:
                return "春"
            case .summer:
                return "夏"
            case .autumn:
                return "秋"
            }
        }

        var next: Season {
            switch self {
            case .winter:
                return .spring
            case .spring:
                return .summer
            case .summer:
                return .autumn
            case .autumn:
                return .winter
            }
        }

        var previous: Season {
            switch self {
            case .winter:
                return .autumn
            case .spring:
                return .winter
            case .summer:
                return .spring
            case .autumn:
                return .summer
            }
        }
    }
}
