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
    static var reducer: Reducer<HouseListState, HouseListAction, HouseListEnvironment> {
        Reducer.combine(
            HouseListRowModule.reducer
            .forEach(
                state: \.rowStates,
                action: /HouseListAction.row,
                environment: {
                    .init(mainQueue: $0.mainQueue, fetchHouse: $0.fetchHouse)
                }
            ),
            Reducer<HouseListState, HouseListAction, HouseListEnvironment> { state, action, environment in
                switch action {
                case .onAppear:
                    return .init(value: .fetchHouses)
                case .refresh:
                    return .init(value: .fetchHouses)
                case .fetchHouses:
                    state.isLoading = true
                    return environment
                        .fetchHouses(state.page, state.pageSize)
                        .receive(on: environment.mainQueue())
                        .catchToEffect()
                        .map(HouseListAction.housesResponse)
                case let .housesResponse(.success(houses)):
                    state.allHousesLoaded = houses.count < state.pageSize
                    state.isLoading = false
                    state.rowStates = .init(uniqueElements: houses.map { HouseListRowState(id: UUID(), dataModel: $0) })
                case let .housesResponse(.failure(error)):
                    state.isLoading = false
                    return .init(value: .presentAlert(error: error))
                case .fetchNextHouses:
                    // TODO: reset page if failed?
                    guard !state.allHousesLoaded else {
                        return .none
                    }

                    if var lastRowState = state.rowStates.last {
                        lastRowState.isLoading = true
                        state.rowStates.updateOrAppend(lastRowState)
                    }

                    state.page += 1
                    return environment
                        .fetchHouses(state.page, state.pageSize)
                        .receive(on: environment.mainQueue())
                        .catchToEffect()
                        .map(HouseListAction.nextHousesResponse)
                case let .nextHousesResponse(.success(houses)):
                    state.allHousesLoaded = houses.count < state.pageSize

                    if var lastRowState = state.rowStates.last {
                        lastRowState.isLoading = false
                        state.rowStates.updateOrAppend(lastRowState)
                    }

                    houses.map { HouseListRowState(id: UUID(), dataModel: $0) }
                        .forEach { state.rowStates.append($0) }
                case let .nextHousesResponse(.failure(error)):
                    if var lastRowState = state.rowStates.last {
                        lastRowState.isLoading = false
                        state.rowStates.updateOrAppend(lastRowState)
                    }
                    return .init(value: .presentAlert(error: error))
                case let .row(id, action):
                    switch action {
                    case .onAppear:
                        guard let rowState = state.rowStates.first(where: { $0.id == id }) else {
                            return .none
                        }
                        guard let index = state.rowStates.firstIndex(of: rowState) else {
                            return .none
                        }
                        guard index == state.rowStates.endIndex - 1 else {
                            return .none
                        }
                        return .init(value: .fetchNextHouses)
                    case let .houseResponse(id, .success(dataModel)):
                        state.selection = .init(.init(dataModel: dataModel), id: id)
                    default: ()
                    }
                case let .presentAlert(error):
                    state.alertState = AlertState(title: TextState("Error"), message: TextState(error.localizedDescription))
                case .alertDismissed:
                    state.alertState = nil
                }
                return .none
            }
        )
    }
}
