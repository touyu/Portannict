//
//  ActivityRecordView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/31.
//

import SwiftUI
import KingfisherSwiftUI

struct ActivityRecordView: View {
    let record: RecordFragment

    @State var isPresented: Bool = false

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            KFImage(record.user.avatarUrl)
                .resizable()
                .clipShape(Circle())
                .frame(width: 40, height: 40, alignment: .leading)
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(record.user.name)
                        .font(.system(size: 14, weight: .bold, design: .default))
                    Text("@\(record.user.username)")
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                    Text("・10分前")
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                }
                Text("記録しました")
                Button(action: {
                    isPresented = true
                }) {
                    QuoteWorkView(work: .constant(record.work.fragments.workFragment))
                        .frame(height: 80)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 0.5))
                }
                .sheet(isPresented: $isPresented) {
                    WorkView(workID: record.work.fragments.workFragment.annictId)
                }
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
