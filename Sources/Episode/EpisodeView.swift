//
//  EpisodeView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/18.
//

import SwiftUI

struct EpisodeView: View {
    let episode: EpisodeFragment

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(episode.numberText)
                        .font(.headline, weight: .bold)
                    Text(episode.title)
                        .font(.title, weight: .bold)
                }
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            }
        }
    }
}

struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeView(episode: .init(id: "", annictId: 0, title: "魔神が生まれた日", numberText: "第１話", viewerRecordsCount: 0))
    }
}
