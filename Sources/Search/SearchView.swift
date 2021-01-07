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

    private var works: [WorkFragment] = [.dummy, .dummy, .dummy, .dummy, .dummy]

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    SearchBar("タイトルを入力", text: $searchText)
                    if searchText.isEmpty {

                    } else {
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
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                }
            }
            .navigationBarTitle("Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
