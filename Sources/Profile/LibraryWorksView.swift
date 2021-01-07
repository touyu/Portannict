//
//  LibraryWorksView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/07.
//

import SwiftUI
import KingfisherSwiftUI

struct LibraryWorksView: View {
    let status: StatusState
    let count: Int

    @State private var works: [WorkFragment] = []

    init(status: StatusState, count: Int) {
        self.status = status
        self.count = count
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(status.title) \(count)")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .padding(.leading, 16)
                Spacer()
                Text("もっと見る")
                    .font(.system(size: 12))
                    .padding(.trailing, 16)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 12) {
                    ForEach(works.indices, id: \.self) { index in
                        LibraryWorkView(work: works[index])
                            .frame(width: 140, height: 140 * 1.7)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
        }
        .onAppear {
            fetch()
        }
    }

    private func fetch() {
        Network.shared.apollo.fetch(query: GetViewerWorksQuery(first: 10, state: status)) { result in
            switch result {
            case .success(let data):
                works = data.data?.viewer?.works?.edges?.compactMap { $0?.node?.fragments.workFragment } ?? []
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct LibraryWorksView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryWorksView(status: .watching, count: 100)
            .previewLayout(.fixed(width: 375, height: 400))
    }
}

