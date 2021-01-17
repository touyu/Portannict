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

    @State private var isEditing: Bool = false

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
                        SearchRecommendedWorksView(viewModel: .init())
                    } else {
                        SearchResultsView(works: $viewModel.state.searchResultWorks)
                    }
                }
                .padding(.bottom, 40)
            }
            .navigationBarTitle("Search")
            .gesture(
                DragGesture().onChanged { value in
                    Keyboard.dismiss()
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
