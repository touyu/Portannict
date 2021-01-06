//
//  KFImage.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/06.
//

import Foundation
import KingfisherSwiftUI

extension KFImage {
    init(_ url: String?) {
        let stringURL = url ?? ""
        self.init(URL(string: stringURL))
    }

    init(_ workID: Int) {
        let url = "\(Constants.baseImageURL)/images/\(workID)"
        self.init(url)
    }
}
