//
//  LibraryWorksView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/07.
//

import SwiftUI
import KingfisherSwiftUI

struct LibraryWorksView: View {
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .padding(.leading, 16)
                Spacer()
                Text("もっと見る")
                    .font(.system(size: 12))
                    .padding(.trailing, 16)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    LibraryWorkView(work: .dummy)
                    LibraryWorkView(work: .dummy)
                    LibraryWorkView(work: .dummy)
                    LibraryWorkView(work: .dummy)
                    LibraryWorkView(work: .dummy)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
        }
    }
}

struct LibraryWorkView: View {
    let work: WorkFragment

    @State var isPresent: Bool = false

    var body: some View {
        Button(action: {
            isPresent = true
        }, label: {
            VStack(alignment: .leading, spacing: 0) {
                KFImage(work.annictId)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                Text(work.title)
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
                    .padding(8)
            }
            .frame(width: 120)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(4)
        })
        .sheet(isPresented: $isPresent) {
            WorkView(workID: work.annictId)
        }
    }
}
