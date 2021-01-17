//
//  AllRatingsStateView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/18.
//

import SwiftUI

struct AllRatingsStateView: View {
    let review: ReviewFragment

    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text("評価")
                .font(.system(size: 14), weight: .bold)
            HStack(alignment: .center) {
                if let ratingAnimationState = review.ratingAnimationState {
                    Text("映像")
                        .font(.system(size: 14))
                    Spacer()
                    RatingStateView(ratingState: ratingAnimationState)
                        .frame(width: 74, alignment: .leading)
                }
            }
            HStack(alignment: .center) {
                if let ratingMusicState = review.ratingMusicState {
                    Text("音楽")
                        .font(.system(size: 14))
                    Spacer()
                    RatingStateView(ratingState: ratingMusicState)
                        .frame(width: 74, alignment: .leading)
                }
            }
            HStack(alignment: .center) {
                if let ratingStoryState = review.ratingStoryState {
                    Text("ストーリー")
                        .font(.system(size: 14))
                    Spacer()
                    RatingStateView(ratingState: ratingStoryState)
                        .frame(width: 74, alignment: .leading)
                }
            }
            HStack(alignment: .center) {
                if let ratingCharacterState = review.ratingCharacterState {
                    Text("キャラクター")
                        .font(.system(size: 14))
                    Spacer()
                    RatingStateView(ratingState: ratingCharacterState)
                        .frame(width: 74, alignment: .leading)
                }
            }
            HStack(alignment: .center) {
                if let ratingOverallState = review.ratingOverallState {
                    Text("全体")
                        .font(.system(size: 14))
                    Spacer()
                    RatingStateView(ratingState: ratingOverallState)
                        .frame(width: 74, alignment: .leading)
                }
            }
        }
    }
}

struct AllRatingsStateView_Previews: PreviewProvider {
    static var previews: some View {
        AllRatingsStateView(review: .dummy)
            .frame(width: 200)
            .padding(16)
            .background(Color.secondarySystemBackground)
            .cornerRadius(8)
            .previewLayout(.fixed(width: 300, height: 300))

        AllRatingsStateView(review: .dummy2)
            .frame(width: 200)
            .padding(16)
            .background(Color.secondarySystemBackground)
            .cornerRadius(8)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}

