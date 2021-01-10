//
//  WorkHeaderView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/30.
//

import SwiftUI
import KingfisherSwiftUI

struct WorkHeaderView: View {
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
                KFImage("\(Constants.baseImageURL)/images/\(work.annictId)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.width * 1.5, alignment: .top)
                    .background(Color.gray)
                LinearGradient(gradient: gradient,
                               startPoint: .top,
                               endPoint: .bottom)
                    .frame(width: geometry.size.width, height: geometry.size.width * 1.5)
                Text(work.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(x: 16, y: -32)
                    .frame(maxWidth: geometry.size.width - 32, alignment: .leading)
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
        WorkFragment(id: "", annictId: 6524, title: "PSYCHO-PASS", episodesCount: 0, watchersCount: 0, reviewsCount: 0, media: .tv)
    }

    static var dummy2: WorkFragment {
        WorkFragment(id: "", annictId: 0, title: "No Title No Title No Title", episodesCount: 0, watchersCount: 0, reviewsCount: 0, media: .tv)
    }

    static var dummy3: WorkFragment {
        WorkFragment(id: "", annictId: 6524, title: "No Title No Title No Title No Title No Title No Title", episodesCount: 0, watchersCount: 0, reviewsCount: 0, media: .tv)
    }
}
