//
//  HouseListView.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 29.08.21.
//  Copyright © 2021 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture
import SwiftUI

struct HouseListView: View {
    let store: Store<HouseListState, HouseListAction>

    var body: some View {
        WithViewStore(
            store.scope(
                state: { $0.view },
                action: { (viewAction: HouseListView.Action) in
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
                        List(selection: viewStore.binding(get: \.selection, send: HouseListView.Action.setSelection)) {
                            ForEachStore(
                                store.scope(state: { _ in value }, action: HouseListAction.row)
                            ) { rowStore in
                                HouseListRowView(store: rowStore)
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
            .navigationTitle("Houses")
        }
    }
}