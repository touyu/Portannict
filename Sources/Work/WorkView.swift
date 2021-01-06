//
//  WorkView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/30.
//

import SwiftUI
import KingfisherSwiftUI
import Apollo

struct WorkView: View {
    private let black = Color(hex: 0x222222)

    let workID: Int

    @State var work: SearchWorksByIdQuery.Data.SearchWork.Node?

    init(workID: Int) {
        print(workID)
        self.workID = workID
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                if let work = work {
                    WorkHeaderView(work: work.fragments.workFragment)
                        .frame(width: geometry.size.width, height: geometry.size.width * 1.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    LazyVStack(alignment: .leading, spacing: 24) {
                        Text("Episodes")
                            .font(.title2)
                            .fontWeight(.bold)
                        ForEach((work.episodes?.nodes ?? []).indices) { index in
                            if let episode = work.episodes?.nodes?[index] {
                                WorkEpisodeCell(episode: episode)
                            }
                        }
                        Button(action: {

                        }, label: {
                            Spacer()
                            Text("もっと見る")
                                .font(.system(size: 14))
                            Spacer()

                        })
                        //                    Text("Charactors")
                        //                        .font(.title2)
                        //                        .fontWeight(.bold)
                        //                    ForEach(10..<15, id: \.self) { i in
                        //                        WorkEpisodeCell(number: i+1, title: "魔神が生まれた日")
                        //                    }
                    }
                    .padding(.init(top: 0, leading: 16, bottom: 48, trailing: 16))
                }
            }
        }
        .background(black)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            fetch()
        }
    }

    private func fetch() {
        Network.shared.apollo.fetch(query: SearchWorksByIdQuery(annictId: workID)) { result in
            switch result {
            case .success(let data):
                self.work = data.data?.searchWorks?.nodes?.first ?? nil
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkView(workID: 865)
    }
}

struct WorkEpisodeCell: View {
    let episode: SearchWorksByIdQuery.Data.SearchWork.Node.Episode.Node

    var body: some View {
        VStack(alignment: .leading) {
            Text(episode.numberText ?? "Unknown")
                .font(.system(size: 14))
            Text(episode.title ?? "Unknown")
                .font(.system(size: 16))
        }
    }
}

extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}
