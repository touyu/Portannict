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
                        SearchRecomendedWorksView(title: viewModel.state.annictSeason.title,
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


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
                    LibraryWorkView(work: work)
                        .aspectRatio(3/5, contentMode: .fit)
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
