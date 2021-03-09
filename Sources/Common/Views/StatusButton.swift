//
//  StatusButton.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/17.
//

import SwiftUI

struct StatusButton: View {
    let state: StatusState
    let action: (() -> Void)?

    private var fontSize: CGFloat = 16

    init(state: StatusState, action: (() -> Void)? = nil) {
        self.state = state
        self.action = action
    }

    var body: some View {
        GeometryReader { geo in
            Button(action: {
                action?()
            }, label: {
                HStack(alignment: .center, spacing: 8) {
                    Text(viewerStatusStateTitle(state: state))
                        .font(.system(size: fontSize))
                        .foregroundColor(state != .noState ? .white : .primary)
                    Image(systemName: .arrowtriangleDownFill)
                        .font(.system(size: fontSize/2))
                        .foregroundColor(state != .noState ? .white : .primary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            })
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .frame(maxWidth:.infinity, maxHeight: .infinity)
            .background(state != .noState ? .blue : Color(.secondarySystemBackground))
            .cornerRadius(geo.size.height / 2)
        }
    }

    private func viewerStatusStateTitle(state: StatusState?) -> String {
        if let title = state?.title, !title.isEmpty {
            return title
        }
        return "ステータスを変更"
    }

    func fontSize(_ size: CGFloat) -> StatusButton {
        var result = self
        result.fontSize = size
        return result
    }
}

struct StatusButton_Previews: PreviewProvider {
    static var previews: some View {
        StatusButton(state: .watching)
            .fontSize(32)
            .previewLayout(.fixed(width: 300, height: 100))
        StatusButton(state: .noState)
            .frame(height: 32)
            .previewLayout(.fixed(width: 300, height: 100))
        StatusButton(state: .watching)
            .frame(height: 32)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
