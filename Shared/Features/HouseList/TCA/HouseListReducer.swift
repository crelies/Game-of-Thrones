//
//  HouseListReducer.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 29.08.21.
//  Copyright © 2021 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture

enum HouseListModule {}

extension HouseListModule {
    private struct FetchHousesID: Hashable {}

    static var reducer: Reducer<HouseListState, HouseListAction, HouseListEnvironment> {
        .combine(
            HouseListRowModule.reducer
                .forEach(
                    state: \.self,
                    action: /.self,
                    environment: {
                        $0
                    }
                )
                .optional()
                .pullback(
                    state: \.viewState.value,
                    action: /HouseListAction.row,
                    environment: {
                        .init(mainQueue: $0.mainQueue, fetchHouse: $0.fetchHouse)
                    }
                ),
            .init { state, action, environment in
                switch action {
                case .onAppear:
                    guard state.viewState == .loading() else {
                        return .none
                    }

                    return .init(value: .refresh)

                case .refresh:
                    return .init(value: .fetchHouses)

                case .fetchHouses:
                    state.viewState = .loading(state.viewState.value)

                    return environment
                        .fetchHouses(state.page, state.pageSize)
                        .receive(on: environment.mainQueue())
                        .catchToEffect(HouseListAction.housesResponse)
                        .cancellable(id: FetchHousesID(), cancelInFlight: true)

                case let .housesResponse(.success(houses)):
                    state.allHousesLoaded = houses.count < state.pageSize
                    state.viewState = .loaded(.init(uniqueElements: houses.map { HouseListRowState(id: $0.id.absoluteString, dataModel: $0) }))

                case let .housesResponse(.failure(error)):
                    state.viewState = .failure(error)

                case .fetchNextHouses:
                    // TODO: reset page if failed?
                    guard !state.allHousesLoaded else {
                        return .none
                    }

                    state.page += 1

                    state.viewState = .loading(state.viewState.value)

                    return environment
                        .fetchHouses(state.page, state.pageSize)
                        .receive(on: environment.mainQueue())
                        .catchToEffect(HouseListAction.nextHousesResponse)
                        .cancellable(id: FetchHousesID(), cancelInFlight: true)

                case let .nextHousesResponse(.success(houses)):
                    state.allHousesLoaded = houses.count < state.pageSize
                    let newRows = houses.map { HouseListRowState(id: $0.id.absoluteString, dataModel: $0) }

                    var currentRows = state.viewState.value ?? []
                    currentRows.append(contentsOf: newRows)
                    state.viewState = .loaded(currentRows)

                case let .nextHousesResponse(.failure(error)):
                    state.viewState = .loaded(state.viewState.value ?? [])
                    return .init(value: .presentAlert(error: error))

                case let .row(id, action):
                    switch action {
                    case .onAppear:
                        guard let value = state.viewState.value else {
                            return .none
                        }
                        guard let rowState = value.first(where: { $0.id == id }) else {
                            return .none
                        }
                        guard let index = value.firstIndex(of: rowState) else {
                            return .none
                        }
                        guard index == value.endIndex - 1 else {
                            return .none
                        }
                        return .init(value: .fetchNextHouses)

                    default: ()
                    }

                case let .presentAlert(error):
                    state.alertState = AlertState(
                        title: TextState("Error"),
                        message: TextState(error.localizedDescription)
                    )

                case .alertDismissed:
                    state.alertState = nil

                case let .setSelection(selection: .some(id)):
                    guard let rowState = state.viewState.value?.first(where: { $0.id == id }) else {
                        return .none
                    }
                    state.selection = .init(id: id, url: rowState.dataModel.url)

                case .setSelection(selection: .none):
                    state.selection = nil

                default: ()
                }

                return .none
            }
        )
    }
}