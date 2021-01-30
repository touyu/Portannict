//
//  SelectStatusSegmentedView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/19.
//

import SwiftUI

struct SelectStatusSegmentedView: View {

    @Binding private var state: RatingState?
    private let states: [RatingState] = [.bad, .average, .good, .great]

    init(state: Binding<RatingState?>) {
        self._state = state
    }

    var body: some View {
        HStack {
            ForEach(states.indices, id: \.self) { index in
                Button(action: {
                    withAnimation(.easeOut(duration: 0.3)) {
                        state = state == states[index] ? nil : states[index]
                    }
                }, label: {
                    if state == states[index] {
                        Text(states[index].title)
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 26)
                            .background(state?.color)
                            .cornerRadius(8)
                    } else {
                        Text(states[index].title)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                            .frame(height: 26)
                            .background(.clear)
                            .cornerRadius(8)
                            .border(Color.gray, width: 0.5, cornerRadius: 8)
                    }
                })
            }
        }
    }
}

struct SelectStatusSegmentedView_Previews: PreviewProvider {
    static var previews: some View {
        SelectStatusSegmentedView(state: .constant(nil))
            .previewLayout(.fixed(width: 375, height: 200))
        SelectStatusSegmentedView(state: .constant(.good))
            .previewLayout(.fixed(width: 375, height: 200))
        //        SelectStatusSegmentedView(state: nil)
        //            .previewLayout(.fixed(width: 375, height: 200))
    }
}

struct TextView: View {
    @State var state: RatingState?

    var body: some View {
        SelectStatusSegmentedView(state: $state)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(state: nil)
    }
}
