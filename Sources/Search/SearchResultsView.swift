//
//  SearchResultsView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/11.
//

import SwiftUI
import KingfisherSwiftUI

struct SearchResultsView: View {
    @Binding var works: [WorkFragment]

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text("検索結果")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
            }
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(works.indices, id: \.self) { index in
                    SearchResultView(work: $works[index])
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(works: .constant(Array(repeating: .dummy, count: 4)))
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 370, height: 600))
    }
}
