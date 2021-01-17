//
//  EpisodeView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/18.
//

import SwiftUI

struct EpisodeView: View {
    let episode: EpisodeFragment

    @State private var records: [RecordFragment] = []

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(episode.numberText)
                        .font(.headline, weight: .bold)
                    Text(episode.title)
                        .font(.title, weight: .bold)
                }
//                .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                ForEach(records.indices, id: \.self) { index in
                    ActivityRecordView(record: $records[index])
                        .hideQuote()
                }
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        }
        .onAppear {
            fetch()
        }
    }

    private func fetch() {
        let query = SearchEpisodeRecordsQuery(annictId: episode.annictId, first: 30, after: nil)
        Network.shared.apollo.fetch(query: query) { result in
            switch result {
            case .success(let data):
                self.records = data.data?.searchEpisodes?.edges?.first??.node?.records?.edges?.compactMap { $0?.node?.fragments.recordFragment } ?? []
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeView(episode: .init(id: "", annictId: 0, title: "魔神が生まれた日", numberText: "第１話", viewerRecordsCount: 0))
    }
}
