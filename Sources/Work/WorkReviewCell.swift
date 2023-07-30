//
//  WorkReviewCell.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/17.
//

import SwiftUI
import KingfisherSwiftUI
import ComposableArchitecture
import Apollo

extension ReviewFragment: Equatable { }

struct WorkReviewCellState: Equatable, Identifiable {
    let review: ReviewFragment

    var id: GraphQLID {
        return review.id
    }
}

enum WorkReviewCellAction: Equatable {

}

struct WorkReviewCellEnvironment {

}

let workReviewCellReducer = Reducer<WorkReviewCellState, WorkReviewCellAction, WorkReviewCellEnvironment> { state, action, env in
    .none
}


struct WorkReviewCell: View {
    let store: Store<WorkReviewCellState, WorkReviewCellAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            HStack(alignment: .top, spacing: 8) {
                KFImage(viewStore.review.user.fragments.userFragment.avatarUrl)
                    .resizable()
                    .placeholder {
                        Color(hex: 0xE2E2E2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                        Text(viewStore.review.user.fragments.userFragment.name)
                            .font(.system(size: 14, weight: .bold, design: .default))
                        Text("@\(viewStore.review.user.fragments.userFragment.username)")
                            .font(.system(size: 12, weight: .regular, design: .default))
                            .foregroundColor(.gray)
                        Spacer()
                        Text(viewStore.review.createdAt.toDate()?.toRelative())
                            .font(.system(size: 12, weight: .regular, design: .default))
                            .foregroundColor(.gray)
                    }
                    if let _ = viewStore.review.ratingOverallState {
                        AllRatingsStateView(review: viewStore.review)
                            .padding(16)
                            .background(Color.secondarySystemBackground)
                            .cornerRadius(8)
                            .previewLayout(.fixed(width: 300, height: 300))
                    }
                    if !viewStore.review.body.isEmpty {
                        Text(viewStore.review.body)
                            .font(.body)
                    }
                }
            }
        }
    }
}

struct WorkReviewCell_Previews: PreviewProvider {
    static var previews: some View {
        WorkReviewCell(store: Store(initialState: WorkReviewCellState(review: .dummy),
                                    reducer: workReviewCellReducer,
                                    environment: WorkReviewCellEnvironment()))
            .previewLayout(.fixed(width: 375, height: 300))
        WorkReviewCell(store: Store(initialState: WorkReviewCellState(review: .dummy2),
                                    reducer: workReviewCellReducer,
                                    environment: WorkReviewCellEnvironment()))
            .previewLayout(.fixed(width: 375, height: 300))
    }
}
