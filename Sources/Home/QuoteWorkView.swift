//
//  QuoteWorkView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/23.
//

import SwiftUI
import KingfisherSwiftUI

struct QuoteWorkView: View {
    @Binding var work: WorkFragment

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            KFImage(work.annictId)
                .resizable()
                .aspectRatio(3/4, contentMode: .fit)
                .background(Color.gray)
            Text(work.title)
                .font(.subheadline)
                .foregroundColor(Color.primary)
            Spacer(minLength: 0)
        }
    }
}

struct QuoteWorkView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteWorkView(work: .constant(WorkFragment.dummy))
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/375.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/))
    }
}
