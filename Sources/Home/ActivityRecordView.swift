//
//  ActivityRecordView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/03/10.
//

import SwiftUI
import ComposableArchitecture

extension RecordFragment: Equatable {}

struct ActivityRecordState: Equatable {
    var record: RecordFragment
    var quoteWorkState: QuoteWorkState

    init(record: RecordFragment) {
        self.record = record
        self.quoteWorkState = QuoteWorkState(work: record.work.fragments.workFragment,
                                             episode: record.episode.fragments.episodeFragment)
    }
}

enum ActivityRecordAction: Equatable {
    case quoteWork(QuoteWorkAction)
}

struct ActivityRecordEnvironment {

}

let activityRecordReducer = Reducer<ActivityRecordState, ActivityRecordAction, ActivityRecordEnvironment>
    .combine(
        quoteWorkReducer
            .pullback(state: \.quoteWorkState,
                      action: /ActivityRecordAction.quoteWork,
                      environment: { _ in QuoteWorkEnvironment() }),
        Reducer { state, action, env in
            switch action {
            case .quoteWork:
                return .none
            }
        }
    )

struct ActivityRecordView: View {
    let store: Store<ActivityRecordState, ActivityRecordAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            HStack(alignment: .top, spacing: 12) {
                AvatarImageView(viewStore.record.user.avatarUrl)
                    .frame(width: 40, height: 40, alignment: .leading)

                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .center) {
                        Text(viewStore.record.user.name)
                            .font(.system(size: 14, weight: .bold, design: .default))
                        Text("@\(viewStore.record.user.username)")
                            .font(.system(size: 12, weight: .regular, design: .default))
                            .foregroundColor(.gray)
                        Spacer()
                        Text(viewStore.record.createdAt.toDate()?.toRelative())
                            .font(.system(size: 12, weight: .regular, design: .default))
                            .foregroundColor(.gray)
                    }
                    if let ratingState = viewStore.record.ratingState {
                        RatingStateView(ratingState: ratingState)
                    }
                    if let comemnt = viewStore.record.comment, !comemnt.isEmpty {
                        Text(comemnt)
                            .font(.body)
                    }
                    QuoteWorkView(store: store.scope(state: \.quoteWorkState,
                                                     action: ActivityRecordAction.quoteWork))
                }
            }
        }
    }
}

struct ActivityRecordView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityRecordView(store: Store(initialState: ActivityRecordState(record: .dummy),
                                        reducer: activityRecordReducer,
                                        environment: ActivityRecordEnvironment()
        ))
    }
}

extension RecordFragment {
    static var dummy: Self {
        let recordWork = RecordFragment.Work(unsafeResultMap: WorkFragment.dummy.resultMap)
        let recordEpisode = RecordFragment.Episode(id: "", annictId: 124160, title: "Los Angeles Connection", numberText: "Case_1_1", viewerRecordsCount: 0)
        let user = RecordFragment.User(id: "user", name: "touyu", username: "touyu", description: "")
        return RecordFragment(id: "", annictId: 0, comment: "いい話だった", ratingState: .good, createdAt: "2021-01-06T17:20:54Z", user: user, work: recordWork, episode: recordEpisode)
    }
}
