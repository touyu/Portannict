//
//  HomeView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/11.
//

import SwiftUI

struct HomeView: View {
    typealias Activity = GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.Edge.Node

    @ObservedObject var viewModel: HomeViewModel
    @State var activities: [Activity] = []

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(activities.indices, id: \.self) { index in
                        let activity = activities[index]
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
                .padding(.top, 24)
            }
            .navigationBarTitle("Home")
            .onAppear {
                //                viewModel.fetch()
                fetch()
            }
        }
    }

    private func fetch() {
        let query = GetFollowingActivitiesQuery(first: 30, after: nil)
        Network.shared.apollo.fetch(query: query) { result in
            switch result {
            case .success(let data):
                self.activities = data.data?.viewer?.followingActivities?.edges?.compactMap { $0?.node } ?? []
            case .failure(let error):
                print(error)
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

        var work: WorkFragment? {
            switch self {
            case .none:
                return nil
            case .record(let record):
                return record.fragments.recordFragment.work.fragments.workFragment
            case .status(let status):
                return nil
            case .review(let review):
                return nil
            case .multipleRecord(let mRecord):
                return nil
            }
        }
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
