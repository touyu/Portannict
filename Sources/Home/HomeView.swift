//
//  HomeView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/11.
//

import SwiftUI
import SwiftUIX
import SkeletonUI

struct HomeView: View {
    typealias Activity = GetFollowingActivitiesQuery.Data.Viewer.FollowingActivity.Edge.Node

    // ObservedObject
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.state.activities.isEmpty {
                    VStack {
                        ForEach(0..<10) { i in
                            ActivityEmptyView()
                                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        }
                    }
                }

                LazyVStack(spacing: 20) {
                    ForEach(viewModel.state.activities.indices, id: \.self) { index in
                        let activity = viewModel.state.activities[index]
                        activityItemView(activity: activity)
                    }
                    ActivityIndicator()
                        .animated(true)
                        .style(.medium)
                        .frame(height: 80)
                        .onAppear {
                            viewModel.action.send(.fetchMore)
                        }
                }
                .padding(EdgeInsets(top: 24, leading: 16, bottom: 0, trailing: 16))
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
            case .status(let status):
                ActivityStatusView(status: status.fragments.statusFragment)
            case .multipleRecord:
                EmptyView()
            case .none:
                EmptyView()
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
