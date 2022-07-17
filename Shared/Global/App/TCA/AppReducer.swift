//
//  AppReducer.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 31.08.21.
//  Copyright © 2021 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture

enum AppModule {}

extension AppModule {
    static var reducer: Reducer<AppState, AppAction, AppEnvironment> {
        .combine(
            HouseDetailModule.reducer
                .optional()
                .pullback(
                    state: \.selectedHouse,
                    action: /AppAction.houseDetail,
                    environment: {
                        .init(mainQueue: $0.mainQueue, fetchHouse: $0.fetchHouse)
                    }
                )
            ,
            CategoryListModule.reducer
                .optional()
                .pullback(
                    state: \.categoryList,
                    action: /AppAction.categoryList,
                    environment: {
                        .init(
                            mainQueue: $0.mainQueue,
                            fetchHouses: $0.fetchHouses,
                            fetchHouse: $0.fetchHouse
                        )
                    }
                )
            ,
            Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
                switch action {
                case let .setSelectedCategory(.some(category)):
                    state.category = category
                    switch category {
                    case .houses:
                        state.categoryList = .houseList(.init())
                    default:
                        state.categoryList = nil
                        state.selectedHouse = nil
                    }

                case .setSelectedCategory(.none):
                    state.category = nil
                    state.categoryList = nil

                case .categoryList(.houseList(.setSelection(selection: .some))):
                    switch state.categoryList {
                    case let .houseList(houseListState):
                        state.selectedHouse = houseListState.selection
                    default: ()
                    }

                case .categoryList(.houseList(.setSelection(selection: .none))):
                    state.selectedHouse = nil

                default: ()
                }
                return .none
            }
        )
    }
}
