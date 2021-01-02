//
//  ActivityRecordView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/31.
//

import SwiftUI

struct ActivityRecordView: View {
    let record: RecordFragment

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .frame(width: 40, height: 40, alignment: .leading)
                .foregroundColor(.gray)
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(record.user.name)
                        .font(.system(size: 14, weight: .bold, design: .default))
                    Text("\(record.user.username)")
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                    Text("・10分前")
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                }
                Text("記録しました")
//                QuoteWorkView(work: activityStatus.work)
//                    .frame(height: 80)
//                    .cornerRadius(8)
//                    .overlay(RoundedRectangle(cornerRadius: 8)
//                                .stroke(Color.gray, lineWidth: 0.5))
            }
            Spacer(minLength: 0)
        }
    }
}

struct ActivityRecordView_Previews: PreviewProvider {
    static var previews: some View {
        let recordWork = RecordFragment.Work(id: "record", annictId: 586, title: "Test", episodesCount: 0, watchersCount: 0, reviewsCount: 0)
        let user = RecordFragment.User(id: "user", name: "touyu", username: "touyu")
        return ActivityRecordView(record: RecordFragment(id: "", annictId: 0, user: user, work: recordWork))
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/375.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/))
    }
}
