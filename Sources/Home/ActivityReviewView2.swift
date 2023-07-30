//
//  ActivityReviewView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/07.
//

import SwiftUI
import KingfisherSwiftUI

struct ActivityReviewView2: View {
    @Binding var review: ReviewFragment

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AvatarImageView(review.user.avatarUrl)
                .frame(width: 40, height: 40, alignment: .leading)
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    Text(review.user.name)
                        .font(.system(size: 14, weight: .bold, design: .default))
                    Text("@\(review.user.username)")
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                    Spacer()
                    Text(review.createdAt.toDate()?.toRelative())
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                }
                if let state = review.ratingOverallState {
                    RatingStateView(ratingState: state)
                }
                Text(review.body)
                    .font(.body)
                QuoteWorkView2(work: $review.work.fragments.workFragment)
            }
        }
    }
}

struct ActivityReviewView2_Previews: PreviewProvider {
    static var previews: some View {
        let review = ReviewFragment(id: "", annictId: 0, body: "", createdAt: "", user: .init(unsafeResultMap: UserFragment.dummy.resultMap), work: .init(unsafeResultMap: WorkFragment.dummy.resultMap))
        ActivityReviewView2(review: .constant(review))
            .previewLayout(.fixed(width: 375, height: 200))
    }
}
