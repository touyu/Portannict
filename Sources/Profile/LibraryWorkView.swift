//
//  LibraryWorkView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/07.
//

import SwiftUI
import KingfisherSwiftUI
import ComposableArchitecture

struct LibraryWorkView: View {
    let work: WorkFragment

    @State private var isPresent: Bool = false
    private let maxWidth: CGFloat = 140


    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                isPresent = true
            }, label: {
                ZStack(alignment: .bottom) {
                    WorkImage(workID: work.annictId)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width)
                    Text(work.title)
                        .lineLimit(2)
                        .font(.system(size: 12))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                }
                .cornerRadius(4)
            })
            //            .frame(height: geometry.size.width * 5/3)
            .sheet(isPresented: $isPresent) {
                WorkView(store: Store(initialState: WorkState(workID: work.annictId),
                                      reducer: workReducer,
                                      environment: WorkEnvironment(
                                        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                                      )
                    )
                )
            }
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
