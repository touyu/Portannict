//
//  WebView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/18.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var loadURL: URL?
    var loadFileURL: URL?

    init(loadURL: URL?) {
        self.loadURL = loadURL
    }

    init(loadFileURL: URL?) {
        self.loadFileURL = loadFileURL
    }

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let loadURL = loadURL {
            uiView.load(URLRequest(url: loadURL))
        }
        if let loadFileURL = loadFileURL {
            uiView.loadFileURL(loadFileURL, allowingReadAccessTo: loadFileURL)
        }
    }
}
