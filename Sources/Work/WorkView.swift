//
//  WorkView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/30.
//

import SwiftUI
import KingfisherSwiftUI
import Apollo
import SwiftUIX

struct WorkView: View {
    private let black = Color(hex: 0x222222)

    let workID: Int

    @State var work: WorkFragment?
    @State var episodes: [EpisodeFragment] = []
    @State var episodesPageInfo: SearchWorkEpisodesQuery.Data.SearchWork.Node.Episode.PageInfo?
    @State var isEpisodesLoading = false

    @State var reviews: [ReviewFragment] = []
    @State var reviewsPageInfo: PageInfoFragment?
    @State var isReviewsLoading = false

    @State private var showingActionSheet = false

    init(workID: Int) {
        self.workID = workID
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                if let work = work {
                    LazyVStack(alignment: .leading, spacing: 24) {
                        WorkHeaderView(work: work)
                            .frame(width: geometry.size.width, height: geometry.size.width * 1.4, alignment: .center)
                        StatusButton(state: work.viewerStatusState ?? .noState) {
                            showingActionSheet = true
                        }
                        .frame(height: 44)
                        .padding(.init(top: 0, leading: 16, bottom: 16, trailing: 16))
                        .actionSheet(isPresented: $showingActionSheet) {
                            var buttons = StatusState.allCases[0...4]
                                .map { state in
                                    return ActionSheet.Button.default(Text(state.title)) {
                                        self.work?.viewerStatusState = state
                                        updateStatus(id: work.id, state: state)
                                    }
                                }
                            buttons.append(.cancel())
                            return ActionSheet(title: Text("ステータスを変更"), buttons: buttons)
                        }
                        Group {
                            if episodes.count > 0 {
                                episodeSection(work: work)
                            }
                            if reviews.count > 0 {
                                reviewsSection(work: work)
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
            fetchReviews()
        }
    }

    private func episodeSection(work: WorkFragment) -> some View {
        LazyVStack(alignment: .leading, spacing: 20) {
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
                    if isEpisodesLoading {
                        ActivityIndicator()
                            .animated(true)
                            .style(.medium)
                            .frame(height: 40)
                        
                    } else {
                        WorkMoreButton {
                            fetchMoreEpisodes()
                        }
                    }
                    Spacer()
                }
            }
        }
    }

    private func reviewsSection(work: WorkFragment) -> some View {
        LazyVStack(alignment: .leading, spacing: 20) {
            Text("Reviews \(work.reviewsCount)")
                .font(.title2)
                .fontWeight(.bold)
            ForEach(reviews.indices, id: \.self) { index in
                if let review = reviews[index] {
                    WorkReviewCell(review: review)
                }
            }
            if let reviewsPageInfo = reviewsPageInfo, reviewsPageInfo.hasNextPage == true {
                HStack {
                    Spacer()
                    if isReviewsLoading {
                        ActivityIndicator()
                            .animated(true)
                            .style(.medium)
                            .frame(height: 40)

                    } else {
                        WorkMoreButton {
                            fetchMoreReviews()
                        }
                    }
                    Spacer()
                }
            }
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
                self.work = data.data?.searchWorks?.nodes?.first??.fragments.workFragment ?? nil
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
        isEpisodesLoading = true
        guard let pageInfo = episodesPageInfo else { return }
        guard pageInfo.hasNextPage else { return }
        Network.shared.apollo.fetch(query: SearchWorkEpisodesQuery(workAnnictId: workID, first: 30, after: pageInfo.endCursor)) { result in
            switch result {
            case .success(let data):
                let nodes = data.data?.searchWorks?.nodes?.first??.episodes?.edges?.compactMap { $0?.node?.fragments.episodeFragment } ?? []
                self.episodes.append(contentsOf: nodes)
                self.episodesPageInfo = data.data?.searchWorks?.nodes?.first??.episodes?.pageInfo
                isEpisodesLoading = false
            case .failure(let error):
                print(error)
            }
        }
    }

    private func updateStatus(id: GraphQLID, state: StatusState) {
        let mutation = UpdateStatusMutation(workId: id, state: state)
        Network.shared.apollo.perform(mutation: mutation) { result in
            switch result {
            case .success(let data):
                guard let work = data.data?.updateStatus?.work?.fragments.workFragment else { return }
                self.work?.viewerStatusState = work.viewerStatusState
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchReviews() {
        Network.shared.apollo.fetch(query: SearchWorkReviewsQuery(workAnnictId: workID, first: 5, after: nil)) { result in
            switch result {
            case .success(let data):
                self.reviews = data.data?.searchWorks?.nodes?.first??.reviews?.edges?.compactMap { $0?.node?.fragments.reviewFragment } ?? []
                self.reviewsPageInfo = data.data?.searchWorks?.nodes?.first??.reviews?.pageInfo.fragments.pageInfoFragment
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchMoreReviews() {
        isReviewsLoading = true
        guard let pageInfo = reviewsPageInfo else { return }
        guard pageInfo.hasNextPage else { return }
        Network.shared.apollo.fetch(query: SearchWorkReviewsQuery(workAnnictId: workID, first: 30, after: pageInfo.endCursor)) { result in
            switch result {
            case .success(let data):
                let nodes = data.data?.searchWorks?.nodes?.first??.reviews?.edges?.compactMap { $0?.node?.fragments.reviewFragment } ?? []
                self.reviews.append(contentsOf: nodes)
                self.reviewsPageInfo = data.data?.searchWorks?.nodes?.first??.reviews?.pageInfo.fragments.pageInfoFragment
                isReviewsLoading = false
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
