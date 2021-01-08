//
//  LibraryWorkView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/07.
//

import SwiftUI
import KingfisherSwiftUI

struct LibraryWorkView: View {
    let work: WorkFragment

    @State private var isPresent: Bool = false
    private let maxWidth: CGFloat = 140


    var body: some View {
        Button(action: {
            isPresent = true
        }, label: {
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 0) {
                    KFImage(work.annictId)
                        .resizable()
                        .placeholder {
                            Text("No Image")
                                .foregroundColor(.systemGray)
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                        }
                        .frame(width: geometry.size.width)
                        .background(Color(.systemGray6))
                    Text(work.title)
                        .lineLimit(2)
                        .font(.system(size: 12))
                        .foregroundColor(.primary)
                        .padding(8)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        })
        .background(Color(.quaternarySystemFill))
        .cornerRadius(4)
        .sheet(isPresented: $isPresent) {
            WorkView(workID: work.annictId)
        }
    }
}

struct LibraryWorkView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryWorkView(work: .dummy)
            .preferredColorScheme(.dark)
            .frame(width: 140, height: 140 * 5/3)
            .previewLayout(.fixed(width: 200, height: 300))
        LibraryWorkView(work: .dummy3)
            .preferredColorScheme(.dark)
            .frame(width: 140, height: 140 * 5/3)
            .previewLayout(.fixed(width: 200, height: 300))
        LibraryWorkView(work: .dummy2)
            .preferredColorScheme(.dark)
            .frame(width: 140, height: 140 * 5/3)
            .previewLayout(.fixed(width: 200, height: 300))
    }
}
