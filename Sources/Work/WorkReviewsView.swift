//
//  WorkReviewsView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/03/09.
//

import SwiftUI
import SwiftUIX
import ComposableArchitecture

extension SearchWorkReviewsQuery.Data.SearchWork.Node.Review: Equatable { }

struct WorkReviewsState: Equatable {
    var work: WorkFragment
    var reviewCellStates: [WorkReviewCellState] = []
    var pageInfo: PageInfoFragment?
    var isLoading: Bool = false
}

enum WorkReviewsAction: Equatable {
    case fetch
    case fetchMore

    case setIsLoading(Bool)
    case setReviews(Result<SearchWorkReviewsQuery.Data.SearchWork.Node.Review, APIError>)
    case appendReviews(Result<SearchWorkReviewsQuery.Data.SearchWork.Node.Review, APIError>)

    case reviewCell(index: Int, action: WorkReviewCellAction)
}

struct WorkReviewsEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
}

let workReviewsReducer = Reducer<WorkReviewsState, WorkReviewsAction, WorkReviewsEnvironment>.combine(
    workReviewCellReducer.forEach(state: \.reviewCellStates,
                                  action: /WorkReviewsAction.reviewCell(index:action:),
                                  environment: { _ in WorkReviewCellEnvironment() }),
    Reducer { state, action, env in
        struct RequestId: Hashable {}
        
        func fetch() -> Effect<SearchWorkReviewsQuery.Data.SearchWork.Node.Review, APIError> {
            return APIClient.shared.fetchEffect(query: SearchWorkReviewsQuery(workAnnictId: state.work.annictId, first: 5))
                .compactMap { $0.searchWorks?.nodes?.first??.reviews }
                .eraseToEffect()
        }

        func fetchMore() -> Effect<SearchWorkReviewsQuery.Data.SearchWork.Node.Review, APIError> {
            guard let pageInfo = state.pageInfo else { return .none }
            guard pageInfo.hasNextPage else { return .none }
            return APIClient.shared.fetchEffect(query: SearchWorkReviewsQuery(workAnnictId: state.work.annictId,
                                                                               first: 30,
                                                                               after: pageInfo.endCursor))
                .compactMap { $0.searchWorks?.nodes?.first??.reviews }
                .eraseToEffect()
        }

        switch action {
        case .fetch:
            let loading = Effect<WorkReviewsAction, Never>(value: .setIsLoading(true))
            let fetchStream = fetch()
                .receive(on: env.mainQueue)
                .catchToEffect()
                .map(WorkReviewsAction.setReviews)
                .cancellable(id: RequestId())
            let finished = Effect<WorkReviewsAction, Never>(value: .setIsLoading(false))
            return Effect.concatenate(loading, fetchStream, finished)
        case .fetchMore:
            let loading = Effect<WorkReviewsAction, Never>(value: .setIsLoading(true))
            let fetchMoreStream = fetchMore()
                .receive(on: env.mainQueue)
                .catchToEffect()
                .map(WorkReviewsAction.appendReviews)
            let finished = Effect<WorkReviewsAction, Never>(value: .setIsLoading(false))
            return Effect.concatenate(loading, fetchMoreStream, finished)
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
            return .none
        case .setReviews(.success(let reviews)):
            state.reviewCellStates = reviews.edges?
                .compactMap { $0?.node?.fragments.reviewFragment }
                .map { WorkReviewCellState(review: $0) } ?? []
            state.pageInfo = reviews.pageInfo.fragments.pageInfoFragment
            return .none
        case .setReviews(.failure(let error)):
            return .none
        case .appendReviews(.success(let reviews)):
            state.reviewCellStates += reviews.edges?
                .compactMap { $0?.node?.fragments.reviewFragment }
                .map { WorkReviewCellState(review: $0) } ?? []
            state.pageInfo = reviews.pageInfo.fragments.pageInfoFragment
            return .none
        case .appendReviews(.failure(let error)):
            return .none
        case .reviewCell:
            return .none
        }
    }
)

struct WorkReviewsView: View {
    let store: Store<WorkReviewsState, WorkReviewsAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            LazyVStack(alignment: .leading, spacing: 24) {
                Text("Reviews \(viewStore.work.reviewsCount)")
                    .font(.title2)
                    .fontWeight(.bold)
                ForEachStore(
                    store.scope(state: \.reviewCellStates, action: WorkReviewsAction.reviewCell(index:action:))
                ) { cellStore in
                    WorkReviewCell(store: cellStore)
                }
                if let pageInfo = viewStore.pageInfo, pageInfo.hasNextPage == true {
                    if !viewStore.isLoading {
                        HStack {
                            Spacer()
                                WorkMoreButton {
                                    viewStore.send(.fetchMore)
                                }
                            Spacer()
                        }
                    }
                }
                if viewStore.isLoading {
                    HStack {
                        Spacer()
                            ProgressView()
                        Spacer()
                    }
                }
            }
            .onAppear {
                viewStore.send(.fetch)
            }
        }
    }
}

struct WorkReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkReviewsView(store: Store(initialState: WorkReviewsState(work: .dummy),
                                     reducer: workReviewsReducer,
                                     environment: WorkReviewsEnvironment(
                                        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                                     )))
    }
}
