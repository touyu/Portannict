//
//  LicensesView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/18.
//

import SwiftUI

struct LicensesView: View {
    private var url: URL? {
        guard let path: String = Bundle.main.path(forResource: "Licenses", ofType: "html") else { return nil }
        return URL(fileURLWithPath: path, isDirectory: false)
    }
    
    var body: some View {
        WebView(loadFileURL: url)
            .frame(width: 375)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("ライセンス")
    }
}

struct LicensesView_Previews: PreviewProvider {
    static var previews: some View {
        LicensesView()
    }
}
