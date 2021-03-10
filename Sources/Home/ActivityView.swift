//
//  ActivityView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/03/10.
//

import SwiftUI
import ComposableArchitecture
import Apollo

struct ActivityState: Equatable, Identifiable {
    var id: GraphQLID {
        return item.id
    }

    var item: ActivityItemFragment

    var recordState: ActivityRecordState?

    init(item: ActivityItemFragment) {
        self.item = item
        switch item.activityItem {
        case .record:
            recordState = ActivityRecordState(record: item.asRecord!.fragments.recordFragment)
        case .status:
            break
        case .review:
            break
        default:
            break
        }
    }
}

enum ActivityAction: Equatable {
    case record(ActivityRecordAction)
}

struct ActivityEnvironment {

}

let activityReducer = Reducer<ActivityState, ActivityAction, ActivityEnvironment>
    .combine(
        activityRecordReducer
            .optional()
            .pullback(state: \.recordState,
                      action: /ActivityAction.record,
                      environment: { _ in ActivityRecordEnvironment() }),
        Reducer { state, action, env in
            switch action {
            case .record:
                return .none
            }
        }
    )

struct ActivityView: View {
    let store: Store<ActivityState, ActivityAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            Group {
                IfLetStore(store.scope(state: \.recordState,
                                       action: ActivityAction.record),
                           then: ActivityRecordView.init(store:))
                //                switch viewStore.item.activityItem {
                //                case .record:
                //                    IfLetStore(store.scope(state: { ActivityRecordState(record: $0.item.asRecord!.fragments.recordFragment) },
                //                                           action: ActivityAction.record),
                //                               then: ActivityRecordView.init(store:))
                //                case .status(let status):
                //                    ActivityStatusView2(status: .constant(status.fragments.statusFragment))
                //                case .review(let review):
                //                    ActivityReviewView2(review: .constant(review.fragments.reviewFragment))
                //                default:
                //                    EmptyView()
                //                }
            }
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        let item = ActivityItemFragment.makeStatus(id: "",
                                                   annictId: 0,
                                                   createdAt: "",
                                                   state: .watching,
                                                   user: .init(unsafeResultMap: UserFragment.dummy.resultMap),
                                                   work: .init(unsafeResultMap: WorkFragment.dummy.resultMap))
        ActivityView(store: Store(initialState: ActivityState(item: item),
                                  reducer: activityReducer,
                                  environment: ActivityEnvironment()))
            .previewLayout(.fixed(width: 375, height: 300))
    }
}
