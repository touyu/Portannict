//
//  ActivityStatusView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/07/23.
//

import SwiftUI
import KingfisherSwiftUI

struct ActivityStatusView2: View {
    @Binding var status: StatusFragment

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AvatarImageView(status.user.avatarUrl)
                .frame(width: 40, height: 40, alignment: .leading)
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    Text(status.user.name)
                        .font(.system(size: 14, weight: .bold, design: .default))
                    Text("@\(status.user.username)")
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                    Spacer()
                    Text(status.createdAt.toDate()?.toRelative())
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                }
                Text("ステータスを「\(status.state.title)」に変更しました")
                    .font(.body)
                QuoteWorkView(work: $status.work.fragments.workFragment)
            }
        }
    }
}

struct ActivityStatusView2_Previews: PreviewProvider {
    static var previews: some View {
        let status = StatusFragment(id: "", annictId: 0, createdAt: "2021-01-06T17:20:54Z",
                           state: .wannaWatch,
                           user: .init(unsafeResultMap: UserFragment.dummy.resultMap),
                           work: .init(unsafeResultMap: WorkFragment.dummy.resultMap))
        return ActivityStatusView2(status: .constant(status))
            .previewLayout(.fixed(width: 375, height: 200))
    }
}
