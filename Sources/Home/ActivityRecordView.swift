//
//  ActivityRecordView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/31.
//

import SwiftUI
import KingfisherSwiftUI
import SkeletonUI

struct ActivityRecordView: View {
    let record: RecordFragment

    @State var isPresentedWorkView: Bool = false
    @State var isPresentedUserView: Bool = false

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            KFImage(record.user.avatarUrl)
                .resizable()
                .clipShape(Circle())
                .foregroundColor(.gray)
                .frame(width: 40, height: 40, alignment: .leading)
                .onTapGesture {
                    isPresentedUserView = true
                }
                .sheet(isPresented: $isPresentedUserView) {
                    UserView(username: record.user.fragments.userFragment.username)
                }

            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    Text(record.user.name)
                        .font(.system(size: 14, weight: .bold, design: .default))
                    Text("@\(record.user.username)")
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                    Spacer()
                    Text(record.createdAt.toDate()?.toRelative())
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                }
                if let ratingState = record.ratingState {
                    RatingStateView(ratingState: ratingState)
                }
                if let comemnt = record.comment, !comemnt.isEmpty {
                    Text(comemnt)
                        .font(.body)
                }
                Button(action: {
                    isPresentedWorkView = true
                }) {
                    QuoteWorkView(work: record.work.fragments.workFragment, episode: record.episode.fragments.episodeFragment)
                        .frame(height: 80)
                        .cornerRadius(8)
                }
                .sheet(isPresented: $isPresentedWorkView) {
                    WorkView(workID: record.work.fragments.workFragment.annictId)
                }
            }
        }
    }
}

struct ActivityRecordView_Previews: PreviewProvider {
    static var previews: some View {
        let recordWork = RecordFragment.Work(id: "record", annictId: 6801, title: "GREAT PRETENDER", episodesCount: 0, watchersCount: 0, reviewsCount: 0)
        let recordEpisode = RecordFragment.Episode(id: "", annictId: 124160, numberText: "Case_1_1", title: "Los Angeles Connection")
        let user = RecordFragment.User(id: "user", name: "touyu", username: "touyu", description: "")
        return ActivityRecordView(record: RecordFragment(id: "", annictId: 0, comment: "いい話だった", ratingState: .good, createdAt: "2021-01-06T17:20:54Z", user: user, work: recordWork, episode: recordEpisode))
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/375.0/*@END_MENU_TOKEN@*/, height: 200))
    }
}

struct ActivityEmptyView: View {
    let rondomValue = Int.random(in: 0...2)

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .skeleton(with: true)
                .frame(width: 40, height: 40, alignment: .leading)

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("")
                        .skeleton(with: true)
                        .frame(height: 14)
                }
                Text("")
                    .skeleton(with: true)
                    .frame(height: 18)
                if rondomValue != 0 {
                    RoundedRectangle(cornerRadius: 8)
                        .skeleton(with: true)
                        .shape(type: .rounded(.radius(8, style: .circular)))
                        .frame(height: 80)
                }
            }
        }
    }
}

struct ActivityEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityEmptyView()
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 375, height: 200))
    }
}
