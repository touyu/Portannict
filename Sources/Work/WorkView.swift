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
import ComposableArchitecture

extension SearchWorkEpisodesQuery.Data.SearchWork.Node.Episode: Equatable { }

struct WorkState: Equatable {
    enum Presentation: View, Identifiable, Hashable {
        case episode(EpisodeFragment)

        var body: some View {
            switch self {
            case .episode(let episode):
                EpisodeView(episode: episode)
            }
        }
    }

    let workID: Int
    var work: WorkFragment?

    var episodes: [EpisodeFragment] = []
    var episodePageInfo: PageInfoFragment?
    var isEpisodesLoading: Bool = false

    var actionSheet: ActionSheetState<WorkAction>?
    var presentation: Presentation?
}

enum WorkAction: Equatable {
    case fetch
    case statusButtonTapped
    case actionSheetDismissed
    case updateStatus(StatusState)
    case episodeCellTapped(Int)
    case episodeDismissed
    case fetchMoreEpisode

    case setWork(Result<WorkFragment, APIError>)
    case setEpisodes(Result<SearchWorkEpisodesQuery.Data.SearchWork.Node.Episode, APIError>)
    case appendEpisodes(Result<SearchWorkEpisodesQuery.Data.SearchWork.Node.Episode, APIError>)
    case setIsEpisodesLoading(Bool)
}

struct WorkEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let workReducer = Reducer<WorkState, WorkAction, WorkEnvironment> { state, action, env in
    struct RequestId: Hashable {}

    func fetch() -> Effect<WorkFragment, APIError> {
        return APIClient.shared.fetchEffect(query: SearchWorksByIdQuery(annictId: state.workID))
            .compactMap { $0.searchWorks?.nodes?.first??.fragments.workFragment }
            .eraseToEffect()
    }

    func fetchEpisodes() -> Effect<SearchWorkEpisodesQuery.Data.SearchWork.Node.Episode, APIError> {
        return APIClient.shared.fetchEffect(query: SearchWorkEpisodesQuery(workAnnictId: state.workID, first: 5))
            .compactMap { $0.searchWorks?.nodes?.first??.episodes }
            .eraseToEffect()
    }

    func fetchMoreEpisodes() -> Effect<SearchWorkEpisodesQuery.Data.SearchWork.Node.Episode, APIError> {
        guard let pageInfo = state.episodePageInfo else { return .none }
        guard pageInfo.hasNextPage else { return .none }
        return APIClient.shared.fetchEffect(query: SearchWorkEpisodesQuery(workAnnictId: state.workID,
                                                                           first: 30,
                                                                           after: pageInfo.endCursor))
            .compactMap { $0.searchWorks?.nodes?.first??.episodes }
            .eraseToEffect()
    }

    switch action {
    case .fetch:
        let fetchStream = fetch()
            .receive(on: env.mainQueue)
            .catchToEffect()
            .map(WorkAction.setWork)

        let fetchEpisodesStream = fetchEpisodes()
            .receive(on: env.mainQueue)
            .catchToEffect()
            .map(WorkAction.setEpisodes)

        return fetchStream
            .merge(with: fetchEpisodesStream)
            .eraseToEffect()
            .cancellable(id: RequestId())
    case .updateStatus(let status):
        return .none
    case .statusButtonTapped:
        state.actionSheet = .init(
            title: TextState("ステータスを変更"),
            buttons: [
                .default(TextState("選択解除"), send: .updateStatus(.noState)),
                .default(TextState("見たい"), send: .updateStatus(.wannaWatch)),
                .default(TextState("見てる"), send: .updateStatus(.watching)),
                .default(TextState("見た"), send: .updateStatus(.watched)),
                .default(TextState("一時中断"), send: .updateStatus(.onHold)),
                .default(TextState("視聴中止"), send: .updateStatus(.stopWatching)),
                .cancel(),
            ]
        )
        return .none
    case .actionSheetDismissed:
        state.actionSheet = nil
        return .none
    case .episodeCellTapped(let index):
        state.presentation = .episode(state.episodes[index])
        return .none
    case .episodeDismissed:
        state.presentation = nil
        return .none
    case .fetchMoreEpisode:
        let loading = Effect<WorkAction, Never>(value: .setIsEpisodesLoading(true))
        let fetchMoreStream = fetchMoreEpisodes()
            .receive(on: env.mainQueue)
            .catchToEffect()
            .map(WorkAction.appendEpisodes)
        let finished = Effect<WorkAction, Never>(value: .setIsEpisodesLoading(false))
        return Effect.concatenate(loading, fetchMoreStream, finished)

    case .setWork(.success(let work)):
        print(work)
        state.work = work
        return .none
    case .setWork(.failure(let error)):
        return .none
    case .setEpisodes(.success(let episodes)):
        state.episodes = episodes.edges?.compactMap { $0?.node?.fragments.episodeFragment } ?? []
        state.episodePageInfo = episodes.pageInfo.fragments.pageInfoFragment
        return .none
    case .setEpisodes(.failure(let error)):
        return .none
    case .appendEpisodes(.success(let episodes)):
        state.episodes += episodes.edges?.compactMap { $0?.node?.fragments.episodeFragment } ?? []
        state.episodePageInfo = episodes.pageInfo.fragments.pageInfoFragment
        return .none
    case .appendEpisodes(.failure(let error)):
        return .none
    case .setIsEpisodesLoading(let isEpisodesLoading):
        state.isEpisodesLoading = isEpisodesLoading
        return .none
    }
}

struct WorkView: View {
    let store: Store<WorkState, WorkAction>

    private let black = Color(hex: 0x222222)

    //    @State private var reviews: [ReviewFragment] = []
    //    @State private var reviewsPageInfo: PageInfoFragment?
    //    @State private var isReviewsLoading = false
    //    @State private var selectedEpisode: EpisodeFragment?

    var body: some View {
        GeometryReader { geometry in
            WithViewStore(store) { viewStore in
                ScrollView(.vertical, showsIndicators: false) {
                    if let work = viewStore.work {
                        VStack(alignment: .leading, spacing: 24) {
                            WorkHeaderView(work: work)
                                .frame(width: geometry.size.width, height: geometry.size.width * 1.4, alignment: .center)
                            StatusButton(state: work.viewerStatusState ?? .noState) {
                                viewStore.send(.statusButtonTapped)
                            }
                            .frame(height: 44)
                            .padding(.init(top: 0, leading: 16, bottom: 16, trailing: 16))
                            .actionSheet(
                                store.scope(state: { $0.actionSheet }),
                                dismiss: .actionSheetDismissed
                            )
                            Group {
                                if viewStore.episodes.count > 0 {
                                    WorkEpisodesView(store: store)
                                }
                                //                                if reviews.count > 0 {
                                //                                    reviewsSection(work: work)
                                //                                }
                            }
                            .padding(.init(top: 0, leading: 16, bottom: 48, trailing: 16))
                        }
                    }
                }
                .onAppear {
                    viewStore.send(.fetch)
                }
            }
            .background(.systemBackground)
            .edgesIgnoringSafeArea(.all)
        }
    }

    //
    //    private func reviewsSection(work: WorkFragment) -> some View {
    //        LazyVStack(alignment: .leading, spacing: 24) {
    //            Text("Reviews \(work.reviewsCount)")
    //                .font(.title2)
    //                .fontWeight(.bold)
    //            ForEach(reviews.indices, id: \.self) { index in
    //                if let review = reviews[index] {
    //                    WorkReviewCell(review: review)
    //                }
    //            }
    //            if let reviewsPageInfo = reviewsPageInfo, reviewsPageInfo.hasNextPage == true {
    //                HStack {
    //                    Spacer()
    //                    if isReviewsLoading {
    //                        ActivityIndicator()
    //                            .animated(true)
    //                            .style(.medium)
    //                            .frame(height: 40)
    //
    //                    } else {
    //                        WorkMoreButton {
    //                            fetchMoreReviews()
    //                        }
    //                    }
    //                    Spacer()
    //                }
    //            }
    //        }
    //    }

    //    private func fetch() {
    //        Network.shared.apollo.fetch(query: SearchWorksByIdQuery(annictId: workID)) { result in
    //            switch result {
    //            case .success(let data):
    //                self.work = data.data?.searchWorks?.nodes?.first??.fragments.workFragment ?? nil
    //            case .failure(let error):
    //                print(error)
    //            }
    //        }
    //    }
    //
    //        private func fetchEpisodes() {
    //            Network.shared.apollo.fetch(query: SearchWorkEpisodesQuery(workAnnictId: workID, first: 5)) { result in
    //                switch result {
    //                case .success(let data):
    //                    self.episodes = data.data?.searchWorks?.nodes?.first??.episodes?.edges?.compactMap { $0?.node?.fragments.episodeFragment } ?? []
    //                    self.episodesPageInfo = data.data?.searchWorks?.nodes?.first??.episodes?.pageInfo
    //                case .failure(let error):
    //                    print(error)
    //                }
    //            }
    //        }
    //
    //    private func fetchMoreEpisodes() {
    //        isEpisodesLoading = true
    //        guard let pageInfo = episodesPageInfo else { return }
    //        guard pageInfo.hasNextPage else { return }
    //        Network.shared.apollo.fetch(query: SearchWorkEpisodesQuery(workAnnictId: workID, first: 30, after: pageInfo.endCursor)) { result in
    //            switch result {
    //            case .success(let data):
    //                let nodes = data.data?.searchWorks?.nodes?.first??.episodes?.edges?.compactMap { $0?.node?.fragments.episodeFragment } ?? []
    //                self.episodes.append(contentsOf: nodes)
    //                self.episodesPageInfo = data.data?.searchWorks?.nodes?.first??.episodes?.pageInfo
    //                isEpisodesLoading = false
    //            case .failure(let error):
    //                print(error)
    //            }
    //        }
    //    }
    //
    //    private func updateStatus(id: GraphQLID, state: StatusState) {
    //        let mutation = UpdateStatusMutation(workId: id, state: state)
    //        Network.shared.apollo.perform(mutation: mutation) { result in
    //            switch result {
    //            case .success(let data):
    //                guard let work = data.data?.updateStatus?.work?.fragments.workFragment else { return }
    //                self.work?.viewerStatusState = work.viewerStatusState
    //            case .failure(let error):
    //                print(error)
    //            }
    //        }
    //    }
    //
    //    private func fetchReviews() {
    //        Network.shared.apollo.fetch(query: SearchWorkReviewsQuery(workAnnictId: workID, first: 5, after: nil)) { result in
    //            switch result {
    //            case .success(let data):
    //                self.reviews = data.data?.searchWorks?.nodes?.first??.reviews?.edges?.compactMap { $0?.node?.fragments.reviewFragment } ?? []
    //                self.reviewsPageInfo = data.data?.searchWorks?.nodes?.first??.reviews?.pageInfo.fragments.pageInfoFragment
    //            case .failure(let error):
    //                print(error)
    //            }
    //        }
    //    }
    //
    //    private func fetchMoreReviews() {
    //        isReviewsLoading = true
    //        guard let pageInfo = reviewsPageInfo else { return }
    //        guard pageInfo.hasNextPage else { return }
    //        Network.shared.apollo.fetch(query: SearchWorkReviewsQuery(workAnnictId: workID, first: 30, after: pageInfo.endCursor)) { result in
    //            switch result {
    //            case .success(let data):
    //                let nodes = data.data?.searchWorks?.nodes?.first??.reviews?.edges?.compactMap { $0?.node?.fragments.reviewFragment } ?? []
    //                self.reviews.append(contentsOf: nodes)
    //                self.reviewsPageInfo = data.data?.searchWorks?.nodes?.first??.reviews?.pageInfo.fragments.pageInfoFragment
    //                isReviewsLoading = false
    //            case .failure(let error):
    //                print(error)
    //            }
    //        }
    //    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkView(store: Store(initialState: WorkState(workID: 865),
                              reducer: workReducer,
                              environment: WorkEnvironment(
                                mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                              )
            )
        )
    }
}

extension EpisodeFragment: Identifiable, Hashable {
    public func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}

struct WorkEpisodesView: View {
    let store: Store<WorkState, WorkAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            LazyVStack(alignment: .leading, spacing: 20) {
                Text("Episodes \(viewStore.work?.episodesCount ?? 0)")
                    .font(.title2)
                    .fontWeight(.bold)
                ForEach(viewStore.episodes.indices, id: \.self) { index in
                    let episode = viewStore.episodes[index]
                    Button(action: {
                        viewStore.send(.episodeCellTapped(index))
                    }, label: {
                        WorkEpisodeCell(episode: episode)
                            .foregroundColor(.primary)
                    })
                    .sheet(item: viewStore.binding(
                            get: { $0.presentation },
                            send: { _ in WorkAction.episodeDismissed } )
                    ) { $0 }
                }
                if let episodesPageInfo = viewStore.episodePageInfo, episodesPageInfo.hasNextPage == true {
                    HStack {
                        Spacer()
                        if viewStore.isEpisodesLoading {
                            ActivityIndicator()
                                .animated(true)
                                .style(.medium)
                                .frame(height: 40)

                        } else {
                            WorkMoreButton {
                                viewStore.send(.fetchMoreEpisode)
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}
