//
//  WorkView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/30.
//

import SwiftUI
import KingfisherSwiftUI

struct WorkView: View {
    private let black = Color(hex: 0x222222)

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                WorkHeaderView()
                    .frame(width: geometry.size.width, height: geometry.size.width * 1.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                LazyVStack(alignment: .leading, spacing: 24) {
                    Text("Episodes")
                        .font(.title2)
                        .fontWeight(.bold)
                    ForEach(0..<5, id: \.self) { i in
                        WorkEpisodeCell(number: i+1, title: "魔神が生まれた日")
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
                .padding(.init(top: 0, leading: 16, bottom: 20, trailing: 16))
            }
        }
        .background(black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkView()
    }
}

struct WorkEpisodeCell: View {
    let number: Int
    let title: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("第\(number)話")
            Text(title)
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
