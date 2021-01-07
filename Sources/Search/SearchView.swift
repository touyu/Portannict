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
    @State private var searchText : String = ""

    private var works: [WorkFragment] = Array(repeating: .dummy, count: 5) + Array(repeating: .dummy2, count: 5) + Array(repeating: .dummy, count: 5) + Array(repeating: .dummy2, count: 5)
    private var results: [WorkFragment] = [.dummy, .dummy, .dummy, .dummy, .dummy]

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    SearchBar("タイトルを入力", text: $searchText)
                    if searchText.isEmpty {
                        SearchRecomendedWorksView(title: "今期", works: works)
                    } else {
                        SearchResultView(works: results)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                }
                .padding(.bottom, 40)
            }
            .navigationBarTitle("Search")
        }
    }
}

struct SearchRecomendedWorksView: View {
    let title: String
    let works: [WorkFragment]

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(title)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Spacer()
                Text("期間を変更する")
            }
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 3), spacing: 10) {
                ForEach(works.indices, id: \.self) { index in
                    let work = works[index]
                    LibraryWorkView(work: work)
                        .aspectRatio(3/5, contentMode: .fit)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
