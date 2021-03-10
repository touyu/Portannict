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
}

enum ActivityAction: Equatable {

}

struct ActivityEnvironment {

}

let activityReducer = Reducer<ActivityState, ActivityAction, ActivityEnvironment>{ state, action, env in
    .none
}

struct ActivityView: View {
    let store: Store<ActivityState, ActivityAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            Group {
                switch viewStore.item.activityItem {
                case .record(let record):
                    ActivityRecordView2(record: .constant(record.fragments.recordFragment))
                case .status(let status):
                    ActivityStatusView2(status: .constant(status.fragments.statusFragment))
                case .review(let review):
                    ActivityReviewView2(review: .constant(review.fragments.reviewFragment))
                default:
                    EmptyView()
                }
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
