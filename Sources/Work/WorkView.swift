//
//  WorkView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/30.
//

import SwiftUI
import KingfisherSwiftUI
import Apollo

struct WorkView: View {
    private let black = Color(hex: 0x222222)

    let workID: Int

    @State var work: SearchWorksByIdQuery.Data.SearchWork.Node?
    @State var episodes: [EpisodeFragment] = []
    @State var episodesPageInfo: SearchWorkEpisodesQuery.Data.SearchWork.Node.Episode.PageInfo?

    init(workID: Int) {
        self.workID = workID
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                if let work = work {
                    LazyVStack(alignment: .leading, spacing: 24) {
//                        WorkHeaderView(work: work.fragments.workFragment)
//                            .frame(width: geometry.size.width, height: geometry.size.width * 1.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Group {
                            if episodes.count > 0 {
                                episodeSection(work: work)
                            }
                            //                            reviewsSection(work: work)
                            //                            charactorsSection(work: work)
                        }
                        .padding(.init(top: 0, leading: 16, bottom: 48, trailing: 16))
                    }
                }
            }
        }
        .background(.systemBackground)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            fetch()
            fetchEpisodes()
        }
    }

    private func episodeSection(work: SearchWorksByIdQuery.Data.SearchWork.Node) -> some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            Text("Episodes \(work.episodesCount)")
                .font(.title2)
                .fontWeight(.bold)
            ForEach(episodes.indices, id: \.self) { index in
                if let episode = episodes[index] {
                    WorkEpisodeCell(episode: episode)
                }
            }
            if let episodesPageInfo = episodesPageInfo, episodesPageInfo.hasNextPage == true {
                HStack {
                    Spacer()
                    WorkMoreButton {
                        fetchMoreEpisodes()
                    }
                    Spacer()
                }
            }
        }
    }

    private func reviewsSection(work: SearchWorksByIdQuery.Data.SearchWork.Node) -> some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            Text("Reviews \(work.episodesCount)")
                .font(.title2)
                .fontWeight(.bold)
            ForEach(episodes.indices) { index in
                if let episode = episodes[index] {
                    WorkEpisodeCell(episode: episode)
                }
            }
            Button(action: {

            }, label: {
                Spacer()
                Text("もっと見る")
                    .font(.system(size: 14))
                Spacer()

            })
        }
    }

    private func charactorsSection(work: SearchWorksByIdQuery.Data.SearchWork.Node) -> some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            Text("Charactors \(work.episodesCount)")
                .font(.title2)
                .fontWeight(.bold)
            ForEach(episodes.indices) { index in
                if let episode = episodes[index] {
                    WorkEpisodeCell(episode: episode)
                }
            }
            Button(action: {

            }, label: {
                Spacer()
                Text("もっと見る")
                    .font(.system(size: 14))
                Spacer()

            })
        }
    }

    private func fetch() {
        Network.shared.apollo.fetch(query: SearchWorksByIdQuery(annictId: workID)) { result in
            switch result {
            case .success(let data):
                self.work = data.data?.searchWorks?.nodes?.first ?? nil
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchEpisodes() {
        Network.shared.apollo.fetch(query: SearchWorkEpisodesQuery(workAnnictId: workID, first: 5)) { result in
            switch result {
            case .success(let data):
                self.episodes = data.data?.searchWorks?.nodes?.first??.episodes?.edges?.compactMap { $0?.node?.fragments.episodeFragment } ?? []
                self.episodesPageInfo = data.data?.searchWorks?.nodes?.first??.episodes?.pageInfo
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchMoreEpisodes() {
        guard let pageInfo = episodesPageInfo else { return }
        guard pageInfo.hasNextPage else { return }
        Network.shared.apollo.fetch(query: SearchWorkEpisodesQuery(workAnnictId: workID, first: 30, after: pageInfo.endCursor)) { result in
            switch result {
            case .success(let data):
                let nodes = data.data?.searchWorks?.nodes?.first??.episodes?.edges?.compactMap { $0?.node?.fragments.episodeFragment } ?? []
                self.episodes.append(contentsOf: nodes)
                self.episodesPageInfo = data.data?.searchWorks?.nodes?.first??.episodes?.pageInfo
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkView(workID: 865)
    }
}

struct WorkEpisodeCell: View {
    let episode: EpisodeFragment

    var body: some View {
        VStack(alignment: .leading) {
            Text(episode.numberText ?? "Unknown")
                .font(.system(size: 14))
            Text(episode.title ?? "Unknown")
                .font(.system(size: 16))
        }
    }
}

struct WorkMoreButton: View {
    let action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
    }

    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text("もっと見る")
                .font(.system(size: 14))
                .foregroundColor(.primary)

        })
        .frame(height: 24)
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .background(Color.secondarySystemBackground)
        .cornerRadius(28)
    }
}

struct WorkMoreButton_Previews: PreviewProvider {
    static var previews: some View {
        WorkMoreButton {

        }
        .previewLayout(.fixed(width: 200, height: 200))
    }
}

extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}
