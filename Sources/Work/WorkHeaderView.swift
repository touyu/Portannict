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

    private var gradient: Gradient {
        Gradient(stops: [Gradient.Stop(color: .clear, location: 0),
                         Gradient.Stop(color: Color.systemBackground.opacity(0.9), location: 0.8),
                         Gradient.Stop(color: Color.systemBackground, location: 1)])
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                WorkImage(workID: work.annictId)
                    .plceholderFont(.system(size: 64))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.width * 1.5)
                ZStack(alignment: .bottomLeading) {
                    LinearGradient(gradient: gradient,
                                   startPoint: .top,
                                   endPoint: .bottom)
                        .frame(width: geometry.size.width, height: geometry.size.width * 1.51) // チラつきを防ぐために画像より大きめに
                    Text(work.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                }
            }
        }
    }
}


struct WorkHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WorkHeaderView(work: .dummy)
        WorkHeaderView(work: .dummy2)
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
