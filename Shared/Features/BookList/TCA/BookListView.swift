//
//  BookListView.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 29/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture
import SwiftUI

struct BookListView: View {
    let store: Store<BookListState, BookListAction>

    var body: some View {
        WithViewStore(
            store.scope(
                state: { $0.view },
                action: { (viewAction: BookListView.Action) in
                    viewAction.feature
                }
            )
        ) { viewStore in
            VStack {
                switch viewStore.viewState {
                case .loading(.none):
                    ProgressView()
                        .onAppear {
                            viewStore.send(.onAppear)
                        }
                case let .loaded(value), let .loading(.some(value)):
                    VStack {
                        List(selection: viewStore.binding(get: \.selection, send: BookListView.Action.setSelection)) {
                            ForEach(value) { book in
                                Label(book.name, systemImage: "book")
                                    .tag(book.id)
                            }
                        }
                        .listStyle(StyleConstants.houseListStyle)
                        .alert(
                            store.scope(state: \.alertState),
                            dismiss: .alertDismissed
                        )
                        .refreshable {
                            await viewStore.send(.refresh, while: \.viewState.isLoading)
                        }

                        if case ViewState.loading = viewStore.viewState {
                            ProgressView()
                        }
                    }
                case let .failure(error):
                    Text(error.localizedDescription)
                }
            }
            .navigationTitle("Books")
            .onDisappear {
                viewStore.send(.onDisappear)
            }
        }
    }
}
