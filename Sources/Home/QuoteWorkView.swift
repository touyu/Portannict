//
//  QuoteWorkView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/23.
//

import SwiftUI
import KingfisherSwiftUI

struct QuoteWorkView: View {
    let work: WorkFragment
    let episode: EpisodeFragment?

    init(work: WorkFragment, episode: EpisodeFragment? = nil) {
        self.work = work
        self.episode = episode
    }

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            KFImage(work.annictId)
                .resizable()
                .aspectRatio(3/4, contentMode: .fit)
                .background(Color.gray)
            VStack(alignment: .leading, spacing: 4) {
                Text(work.title)
                    .font(.system(size: 14))
                    .foregroundColor(Color.primary)
                if let epi = episode {
                    Text("\(epi.numberText ?? "") \(epi.title ?? "")")
                        .font(.system(size: 11))
                        .foregroundColor(Color.primary)
                }
            }
            Spacer(minLength: 0)
        }
        .background(Color(UIColor.secondarySystemBackground))
    }
}

struct QuoteWorkView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteWorkView(work: WorkFragment.dummy)
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/375.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/))
        QuoteWorkView(work: WorkFragment.dummy, episode: EpisodeFragment(id: "", annictId: 0, numberText: "第1話", title: "冒険の始まり"))
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/375.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/))
    }
}
