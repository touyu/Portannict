//
//  WorkReviewCell.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/17.
//

import SwiftUI
import KingfisherSwiftUI

struct WorkReviewCell: View {
    let review: ReviewFragment

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            KFImage(review.user.fragments.userFragment.avatarUrl)
                .resizable()
                .placeholder {
                    Color(hex: 0xE2E2E2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 40, height: 40)
                .cornerRadius(20)
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    Text(review.user.fragments.userFragment.name)
                        .font(.system(size: 14, weight: .bold, design: .default))
                    Text("@\(review.user.fragments.userFragment.username)")
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                    Spacer()
                    Text(review.createdAt.toDate()?.toRelative())
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                }
                if let _ = review.ratingOverallState {
                    AllRatingsStateView(review: review)
                        .padding(16)
                        .background(Color.secondarySystemBackground)
                        .cornerRadius(8)
                        .previewLayout(.fixed(width: 300, height: 300))
                }
                if !review.body.isEmpty {
                    Text(review.body)
                        .font(.body)
                }
            }
        }
    }
}

struct WorkReviewCell_Previews: PreviewProvider {
    static var previews: some View {
        WorkReviewCell(review: .dummy)
            .previewLayout(.fixed(width: 375, height: 300))
        WorkReviewCell(review: .dummy2)
            .previewLayout(.fixed(width: 375, height: 300))
    }
}
