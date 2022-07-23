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
            CharacterDetailModule.reducer
                .optional()
                .pullback(
                    state: \.selectedCharacter,
                    action: /AppAction.characterDetail,
                    environment: {
                        .init(mainQueue: $0.mainQueue, fetchCharacter: $0.characterClient.fetchCharacter)
                    }
                )
            ,
            HouseDetailModule.reducer
                .optional()
                .pullback(
                    state: \.selectedHouse,
                    action: /AppAction.houseDetail,
                    environment: {
                        .init(
                            mainQueue: $0.mainQueue,
                            fetchHouse: $0.houseClient.fetchHouse,
                            fetchCharacter: $0.characterClient.fetchCharacter
                        )
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
                            houseClient: $0.houseClient,
                            characterClient: $0.characterClient
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
                        state.selectedCharacter = nil
                    case .characters:
                        state.categoryList = .characters(.init())
                        state.selectedHouse = nil
                    default:
                        state.categoryList = nil
                        state.selectedHouse = nil
                        state.selectedCharacter = nil
                    }

                case .setSelectedCategory(.none):
                    state.category = nil
                    state.categoryList = nil
                    state.selectedHouse = nil
                    state.selectedCharacter = nil

                case .categoryList(.houseList(.setSelection(selection: .some))):
                    switch state.categoryList {
                    case let .houseList(houseListState):
                        state.selectedHouse = houseListState.selection
                    default: ()
                    }

                case .categoryList(.houseList(.setSelection(selection: .none))):
                    state.selectedHouse = nil

                case .categoryList(.characters(.setSelection(selection: .some))):
                    switch state.categoryList {
                    case let .characters(characterListState):
                        state.selectedCharacter = characterListState.selection
                    default: ()
                    }

                case .categoryList(.characters(.setSelection(selection: .none))):
                    state.selectedCharacter = nil

                case let .houseDetail(.setSelectedHouse(url)):
                    guard let url else {
                        return .none
                    }
                    state.selectedHouse = .init(url: url)

                default: ()
                }
                return .none
            }
        )
    }
}
