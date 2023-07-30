//
//  MonochromeImage.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/29.
//

import SwiftUI

struct MonochromeImage: View {
    let name: String

    private var configurations: [(SwiftUI.Image) -> SwiftUI.Image] = []

    init(_ name: String) {
        self.name = name
    }

    var body: some View {
        configurations
            .reduce(Image(uiImage: grayingImage())) { current, config in
                config(current)
            }
    }

    func resizable(capInsets: EdgeInsets = EdgeInsets(), resizingMode: SwiftUI.Image.ResizingMode = .stretch) -> MonochromeImage {
        configure { $0.resizable(capInsets: capInsets, resizingMode: resizingMode) }
    }

    func configure(_ block: @escaping (SwiftUI.Image) -> SwiftUI.Image) -> MonochromeImage {
        var result = self
        result.configurations.append(block)
        return result
    }

    private func grayingImage() -> UIImage? {
        guard let uiImage = UIImage(named: name),
              let filter = CIFilter(name: "CIPhotoEffectMono") else { return nil }
        filter.setDefaults()
        filter.setValue(CIImage(image: uiImage), forKey: kCIInputImageKey)
        guard let ciImage = filter.outputImage else { return nil }
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}

struct MonochromeImage_Previews: PreviewProvider {
    static var previews: some View {
        MonochromeImage("killlakill")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}

