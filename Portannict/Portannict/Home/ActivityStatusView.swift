//
//  ActivityStatusView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/23.
//

import SwiftUI

struct ActivityStatusView: View {
    @Binding var activityStatus: ActivityStatus

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .frame(width: 40, height: 40, alignment: .leading)
                .foregroundColor(.gray)
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("touyu")
                        .font(.system(size: 14, weight: .bold, design: .default))
                    Text("@touyu")
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                    Text("・10分前")
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                }
                Text("ステータスを見たに変更しました。")
                QuoteWorkView(work: $activityStatus.work)
                    .frame(height: 80)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 0.5))
            }
            Spacer(minLength: 0)
        }
    }
}

struct ActivityStatusView_Previews: PreviewProvider {
    static var previews: some View {
        let item = PreviewModel.activityStatus
        ActivityStatusView(activityStatus: .constant(item))
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/400.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/200.0/*@END_MENU_TOKEN@*/))
    }
}
