//
//  SearchView.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/07.
//

import SwiftUI
import SwiftUIX
import Combine
import KingfisherSwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel = .init()

    @State private var isEditing : Bool = false

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    SearchBar("タイトルを入力", text: $viewModel.searchText, isEditing: $isEditing)
                        .showsCancelButton(isEditing)
                        .onCancel {
                            Keyboard.dismiss()
                        }
                    if viewModel.searchText.isEmpty {
                        SearchResultView(title: viewModel.state.annictSeason.title,
                                         works: viewModel.state.recomendedWorks,
                                         mode: .recommend)
                            .onTapChangeSeasonButton {
                                viewModel.action.send(.fetch(viewModel.state.annictSeason.previous))
                            }
                    } else {
                        SearchResultView(title: "検索結果",
                                         works: viewModel.state.searchResultWorks,
                                         mode: .searchResult)
                    }
                }
                .padding(.bottom, 40)
            }
            .navigationBarTitle("Search")
            .onAppear {
                viewModel.action.send(.fetch(.current))
            }
            .gesture(
                DragGesture().onChanged { value in
                    Keyboard.dismiss()
                }
            )
            .onReceive(
                viewModel.$searchText
                    .debounce(for: 0.4, scheduler: DispatchQueue.main),
                perform: { text in
                    viewModel.action.send(.search(text))
                }
            )
            .onReceive(
                viewModel.$searchText
                    .receive(on: DispatchQueue.main),
                perform: { text in
                    if text.isEmpty {
                        viewModel.action.send(.clearSearchResults)
                    }
                }
            )
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct SearchResultView: View {
    let title: String
    let works: [WorkFragment]
    let mode: Mode

    init(title: String, works: [WorkFragment], mode: Mode) {
        self.title = title
        self.works = works
        self.mode = mode
    }

    private var changeSeasonAction: (() -> Void)?

    enum Mode {
        case recommend
        case searchResult
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(title)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                if mode == .recommend {
                    Spacer()
                    Button("期間を変更する") {
                        changeSeasonAction?()
                    }
                    .foregroundColor(.primary)
                }
            }
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(works.indices, id: \.self) { index in
                    let work = works[index]
                    row(work: work)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
    }

    func row(work: WorkFragment) -> some View {
        HStack(alignment: .top, spacing: 16) {
            KFImage(work.annictId)
                .resizable()
                .placeholder {
                    let placeholder = Text("No Image")
                        .foregroundColor(.systemGray)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                    Color(.lightGray)
                        .overlay(placeholder)
                }
                .aspectRatio(3/4, contentMode: .fit)
                .frame(width: 60)
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 8) {
                Text(work.title)
                    .fontWeight(.semibold)

                Text(work.media.localizedText)
                    .font(.system(size: 12))
                    .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 8))
                    .background(Color(.tertiarySystemBackground))
                    .cornerRadius(4)

                Button(action: {

                }, label: {
                    HStack(alignment: .center, spacing: 8) {
                        Text(viewerStatusStateTitle(state: work.viewerStatusState))
                            .font(.system(size: 13))
                            .foregroundColor(work.viewerStatusState != .noState ? .white : .primary)
                        Image(systemName: .arrowtriangleDownFill)
                            .font(.system(size: 8))
                            .foregroundColor(work.viewerStatusState != .noState ? .white : .primary)
                    }
                })
                .frame(height: 32)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .background(work.viewerStatusState != .noState ? .blue : Color(.tertiarySystemBackground))
                .cornerRadius(16)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }

    func onTapChangeSeasonButton(_ action: @escaping (() -> Void)) -> SearchResultView {
        var result = self
        result.changeSeasonAction = action
        return result
    }

    private func viewerStatusStateTitle(state: StatusState?) -> String {
        if let title = state?.title, !title.isEmpty {
            return title
        }
        return "ステータスを変更"
    }
}

struct SearchResultViiew_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(title: "今期", works: Array(repeating: .dummy, count: 4), mode: .recommend)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 370, height: 600))
    }
}
