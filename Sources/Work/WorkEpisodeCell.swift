//
//  WorkEpisodeCell.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/17.
//

import SwiftUI

struct WorkEpisodeCell: View {
    let episode: EpisodeFragment

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(episode.numberText ?? "Unknown")
                    .font(.system(size: 14))
                Text(episode.title ?? "Unknown")
                    .font(.system(size: 16))
            }
            Spacer()
            Text("\(episode.viewerRecordsCount)")
                .frame(height: 20)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                .background(Color.secondarySystemBackground)
                .cornerRadius(18)
        }
    }
}

struct WorkEpisodeCell_Previews: PreviewProvider {
    static var previews: some View {
        WorkEpisodeCell(episode: .init(id: "", annictId: 0, viewerRecordsCount: 0))
    }
}
