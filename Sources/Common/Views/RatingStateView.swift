//
//  RatingStateView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/07.
//

import SwiftUI

struct RatingStateView: View {
    let ratingState: RatingState

    var body: some View {
        Text(ratingState.title)
            .foregroundColor(.white)
            .font(.system(size: 11))
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .background(ratingState.color)
            .cornerRadius(4)
    }
}

struct RatingStateView_Previews: PreviewProvider {
    static var previews: some View {
        RatingStateView(ratingState: .great)
            .previewLayout(.fixed(width: 100, height: 40))
        RatingStateView(ratingState: .good)
            .previewLayout(.fixed(width: 100, height: 40))
        RatingStateView(ratingState: .average)
            .previewLayout(.fixed(width: 100, height: 40))
        RatingStateView(ratingState: .bad)
            .previewLayout(.fixed(width: 100, height: 40))
    }
}
