//
//  HomeView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/11.
//

import SwiftUI
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

                LazyVStack {
                    ForEach(viewModel.state.activities.indices, id: \.self) { index in
                        let activity = viewModel.state.activities[index]
                        activityItemView(activity: activity)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                    ActivityIndicator(isAnimating: .constant(true), style: .medium)
                        .frame(height: 40)
                        .onAppear {
                            viewModel.action.send(.fetchMore)
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
