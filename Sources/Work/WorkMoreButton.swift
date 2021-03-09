//
//  WorkMoreButton.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/17.
//

import SwiftUI

struct WorkMoreButton: View {
    let action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
    }

    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text("もっと見る")
                .font(.system(size: 14))
                .foregroundColor(.primary)

        })
        .frame(height: 24)
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .background(Color.secondarySystemBackground)
        .cornerRadius(28)
    }
}

struct WorkMoreButton_Previews: PreviewProvider {
    static var previews: some View {
        WorkMoreButton {

        }
        .previewLayout(.fixed(width: 200, height: 200))
    }
}
