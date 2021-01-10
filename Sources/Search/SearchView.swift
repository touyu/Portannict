//
//  SearchView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/07.
//

import SwiftUI
import SwiftUIX
import Combine
import KingfisherSwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel = .init()

    @State private var isEditing : Bool = false

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    SearchBar("タイトルを入力", text: $viewModel.searchText, isEditing: $isEditing)
                        .showsCancelButton(isEditing)
                        .onCancel {
                            Keyboard.dismiss()
                        }
                    if viewModel.searchText.isEmpty {
//                        SearchRecommendedWorksView(season: viewModel.state.annictSeason,
//                                                   works: viewModel.state.recomendedWorks)
//                            .onTapChangeSeasonButton { season in
//                                viewModel.action.send(.fetch(season))
//                            }
                        SearchRecommendedWorksView(viewModel: .init())
                    } else {
                        SearchResultsView(title: "検索結果",
                                          works: viewModel.state.searchResultWorks)
                    }
                }
                .padding(.bottom, 40)
            }
            .navigationBarTitle("Search")
//            .onAppear {
//                viewModel.action.send(.fetch(.current))
//            }
            .gesture(
                DragGesture().onChanged { value in
                    Keyboard.dismiss()
                }
            )
            .onReceive(
                viewModel.$searchText
                    .debounce(for: 0.4, scheduler: DispatchQueue.main),
                perform: { text in
                    viewModel.action.send(.search(text))
                }
            )
            .onReceive(
                viewModel.$searchText
                    .receive(on: DispatchQueue.main),
                perform: { text in
                    if text.isEmpty {
                        viewModel.action.send(.clearSearchResults)
                    }
                }
            )
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
