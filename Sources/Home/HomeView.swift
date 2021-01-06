//
//  HomeView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/11.
//

import SwiftUI

struct HomeView: View {
    typealias Activity = GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.Edge.Node

    // ObservedObject
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.state.activities.indices, id: \.self) { index in
                        let activity = viewModel.state.activities[index]
                        activityItemView(activity: activity)
                            .onAppear {
                                if index == viewModel.state.activities.count-10 {
                                    print("FetchMore")
                                    viewModel.action.send(.fetchMore)
                                }
                            }
                    }
                }
                .padding(.top, 24)
            }
            .navigationBarTitle("Home")
            .onAppear {
                viewModel.action.send(.fetch)
            }
        }
    }

    func activityItemView(activity: Activity) -> some View {
        Group {
            switch activity.activityItem {
            case .record(let record):
                ActivityRecordView(record: record.fragments.recordFragment)
            case .review:
                Text("Review")
            case .status:
                Text("Status")
            case .multipleRecord:
                Text("MultipleRecord")
            case .none:
                Text("None")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel()
        Group {
            HomeView(viewModel: viewModel)
        }
    }
}

extension GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.Edge.Node {
    enum ActivityItem {
        case none
        case record(AsRecord)
        case review(AsReview)
        case status(AsStatus)
        case multipleRecord(AsMultipleRecord)
    }

    var activityItem: ActivityItem {
        if let record = asRecord {
            return .record(record)
        }

        if let review = asReview {
            return .review(review)
        }

        if let status = asStatus {
            return .status(status)
        }

        if let multi = asMultipleRecord {
            return .multipleRecord(multi)
        }

        return .none
    }
}
