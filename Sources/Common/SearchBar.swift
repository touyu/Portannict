//
//  SearchBar.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/07.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    let searchBarStyle: UISearchBar.Style
    @Binding var text: String

    var onCommit: ((String) -> Void)?

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        var onCommit: ((String) -> Void)?

        init(text: Binding<String>, onCommit: ((String) -> Void)?) {
            _text = text
            self.onCommit = onCommit
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            onCommit?(text)
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, onCommit: onCommit)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = searchBarStyle
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchBarStyle: .minimal, text: .constant(""), onCommit: nil)
    }
}
