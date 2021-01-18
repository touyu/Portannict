//
//  WorkImageView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/19.
//

import SwiftUI
import KingfisherSwiftUI

struct WorkImage: View {
    let workID: Int

    private var placeholderFont: Font?

    init(workID: Int) {
        self.workID = workID
    }

    var body: some View {
        KFImage(workID)
            .resizable()
            .placeholder {
                Text("No Image")
                    .foregroundColor(.systemGray)
                    .font(placeholderFont ?? .system(size: 16))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color(hex: 0xE2E2E2))
            }
    }

    func plceholderFont(_ font: Font) -> WorkImage {
        var result = self
        result.placeholderFont = font
        return result
    }
}

struct WorkImage_Previews: PreviewProvider {
    static var previews: some View {
        WorkImage(workID: WorkFragment.dummy.annictId)
            .previewLayout(.fixed(width: 200, height: 200))
        WorkImage(workID: 0)
            .previewLayout(.fixed(width: 200, height: 200))
        WorkImage(workID: 0)
            .plceholderFont(.system(size: 32))
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
