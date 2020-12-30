//
//  HomeView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/11.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    @State var isPresented: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.activities.indices, id: \.self) { index in
                        let activity = $viewModel.activities[index]
                        switch activity.wrappedValue.action {
                        case .status:
                            ActivityStatusView(activityStatus: Binding(activity.status)!)
                                .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
                                .onTapGesture {
                                    isPresented = true
                                }
                                .sheet(isPresented: $isPresented) {
                                    WorkView()
                                }
                        }
                    }
                }
                .padding(.top, 24)
            }
            .navigationBarTitle("Home")
            .onAppear {
                viewModel.fetch()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel(activities: PreviewModel.activities)
        HomeView(viewModel: viewModel)
    }
}
