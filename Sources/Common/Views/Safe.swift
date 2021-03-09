//
//  Safe.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/19.
//

import SwiftUI

// Maybe Swift Bug
// https://stackoverflow.com/questions/63079221/deleting-list-elements-from-swiftuis-list

struct Safe<T: RandomAccessCollection & MutableCollection, C: View>: View {
   typealias BoundElement = Binding<T.Element>
   private let binding: BoundElement
   private let content: (BoundElement) -> C

   init(_ binding: Binding<T>, index: T.Index, @ViewBuilder content: @escaping (BoundElement) -> C) {
      self.content = content
      self.binding = .init(get: { binding.wrappedValue[index] },
                           set: { binding.wrappedValue[index] = $0 })
   }

   var body: some View {
      content(binding)
   }
}

