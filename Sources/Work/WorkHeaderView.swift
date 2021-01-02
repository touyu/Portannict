//
//  WorkHeaderView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/30.
//

import SwiftUI
import KingfisherSwiftUI

struct WorkHeaderView: View {
    private let psychopassURL = URL(string: "https://media.kitsu.io/anime/poster_images/7000/large.jpg?1597696781")
    private let summerwarsURL = URL(string: "https://media.kitsu.io/anime/poster_images/4241/large.jpg?1597697638")

    let work: WorkFragment

    init(work: WorkFragment) {
        self.work = work
    }

    private let black = Color(hex: 0x222222)
    private var gradient: Gradient {
        Gradient(stops: [Gradient.Stop(color: black, location: 0),
                         Gradient.Stop(color: .clear, location: 0.5),
                         Gradient.Stop(color: black.opacity(0.9), location: 0.8),
                         Gradient.Stop(color: black, location: 1)])
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                KFImage(URL(string: "\(Constants.baseImageURL)/images/\(work.annictId)"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.width * 1.5, alignment: .top)
                LinearGradient(gradient: gradient,
                               startPoint: .top,
                               endPoint: .bottom)
                    .frame(width: geometry.size.width, height: geometry.size.width * 1.5)
                Text(work.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(x: 16, y: -32)
            }
        }
    }
}


struct WorkHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkHeaderView(work: .dummy)
        }
    }
}

extension WorkFragment {
    static var dummy: WorkFragment {
        WorkFragment(id: "", annictId: 7193, title: "PSYCHO-PASS", episodesCount: 0, watchersCount: 0, reviewsCount: 0)
    }
}
