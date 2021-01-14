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
                        activityItemView(index: index)
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

    func activityItemView(index: Int) -> some View {
        Group {
            let activity = $viewModel.state.activities[index]
            if let record = activity.wrappedValue.asRecord {
                ActivityRecordView(record: activity.map(\.asRecord!.fragments.recordFragment))
                    .onSelectState { state in
                        viewModel.action.send(.updateWork(record.work.fragments.workFragment.id, state))
                    }
            } else if let _ = activity.wrappedValue.asReview {
                ActivityReviewView(review: activity.map(\.asReview!.fragments.reviewFragment))
            } else if let _ = activity.wrappedValue.asStatus {
                ActivityStatusView(status: activity.map(\.asStatus!.fragments.statusFragment))
            } else {
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
