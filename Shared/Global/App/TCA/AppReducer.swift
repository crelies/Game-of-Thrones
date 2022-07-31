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
            BookDetailModule.reducer
                .optional()
                .pullback(
                    state: \.selectedBook,
                    action: /AppAction.bookDetail,
                    environment: {
                        .init(mainQueue: $0.mainQueue, fetchBook: $0.bookClient.fetchBook)
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
                            characterClient: $0.characterClient,
                            bookClient: $0.bookClient
                        )
                    }
                )
            ,
            Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
                switch action {
                case let .setSelectedCategory(.some(category)):
                    state.selectedCategory = category

                    switch category {
                    case .houses:
                        state.categoryList = .houseList(.init())
                        state.selectedCharacter = nil
                        state.selectedBook = nil
                    case .characters:
                        state.categoryList = .characters(.init())
                        state.selectedHouse = nil
                        state.selectedBook = nil
                    case .books:
                        state.categoryList = .books(.init())
                        state.selectedHouse = nil
                        state.selectedCharacter = nil
                    }

                case .setSelectedCategory(.none):
                    state.selectedCategory = nil
                    state.categoryList = nil
                    state.selectedHouse = nil
                    state.selectedCharacter = nil
                    state.selectedBook = nil

                // MARK: - House list

                case .categoryList(.houseList(.setSelection(selection: .some))):
                    switch state.categoryList {
                    case let .houseList(houseListState):
                        state.selectedHouse = houseListState.selection
                    default: ()
                    }

                case .categoryList(.houseList(.setSelection(selection: .none))):
                    state.selectedHouse = nil

                case .categoryList(.houseList(.onDisappear)):
                    switch state.categoryList {
                    case .houseList:
                        guard state.selectedHouse == nil else {
                            return .none
                        }
                        return .init(value: .setSelectedCategory(category: .none))
                    default: ()
                    }

                // MARK: - Character list

                case .categoryList(.characters(.setSelection(selection: .some))):
                    switch state.categoryList {
                    case let .characters(characterListState):
                        state.selectedCharacter = characterListState.selection
                    default: ()
                    }

                case .categoryList(.characters(.setSelection(selection: .none))):
                    state.selectedCharacter = nil

                case .categoryList(.characters(.onDisappear)):
                    switch state.categoryList {
                    case .characters:
                        guard state.selectedCharacter == nil else {
                            return .none
                        }
                        return .init(value: .setSelectedCategory(category: .none))
                    default: ()
                    }

                // MARK: - Book list

                case .categoryList(.books(.setSelection(selection: .some))):
                    switch state.categoryList {
                    case let .books(bookListState):
                        state.selectedBook = bookListState.selection
                    default: ()
                    }

                case .categoryList(.books(.setSelection(selection: .none))):
                    state.selectedBook = nil

                case .categoryList(.books(.onDisappear)):
                    switch state.categoryList {
                    case .books:
                        guard state.selectedBook == nil else {
                            return .none
                        }
                        return .init(value: .setSelectedCategory(category: .none))
                    default: ()
                    }

                // MARK: - House detail

                case let .houseDetail(.setSelectedHouse(url)):
                    return .init(value: .categoryList(.houseList(.setSelection(selection: url))))

                case let .houseDetail(.setSelectedCharacter(url: url)):
                    if let url {
                        state.selectedCharacter = .init(url: url)
                    }
                    return .init(value: .setSelectedCategory(category: .characters))

                // MARK: - Character detail

                case let .characterDetail(.setSelectedHouse(url: url)):
                    if let url {
                        state.selectedHouse = .init(url: url)
                    }
                    return .init(value: .setSelectedCategory(category: .houses))

                case let .characterDetail(.setSelectedCharacter(url: url)):
                    return .init(value: .categoryList(.characters(.setSelection(selection: url))))

                case let .characterDetail(.setSelectedBook(url: url)):
                    if let url {
                        state.selectedBook = .init(url: url)
                    }
                    return .init(value: .setSelectedCategory(category: .books))

                // MARK: - Book detail

                case let .bookDetail(.setSelectedCharacter(url: url)):
                    if let url {
                        state.selectedCharacter = .init(url: url)
                    }
                    return .init(value: .setSelectedCategory(category: .characters))

                default: ()
                }
                return .none
            }
        )
    }
}
