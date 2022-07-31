//
//  CategoryReducer.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 16/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture
import Foundation

enum CategoryModule {}

extension CategoryModule {
    static var reducer: Reducer<CategoryState, CategoryAction, CategoryEnvironment> {
        .combine(
            CharacterListModule.reducer
                .pullback(
                    state: /CategoryState.characters,
                    action: /CategoryAction.characters,
                    environment: {
                        .init(
                            mainQueue: $0.mainQueue,
                            characterClient: $0.characterClient
                        )
                    }
                )
            ,
            HouseListModule.reducer
                .pullback(
                    state: /CategoryState.houses,
                    action: /CategoryAction.houses,
                    environment: {
                        .init(
                            mainQueue: $0.mainQueue,
                            houseClient: $0.houseClient
                        )
                    }
                )
            ,
            BookListModule.reducer
                .pullback(
                    state: /CategoryState.books,
                    action: /CategoryAction.books,
                    environment: {
                        .init(
                            mainQueue: $0.mainQueue,
                            bookClient: $0.bookClient
                        )
                    }
                )
            ,
            .init { state, action, environment in
                return .none
            }
        )
    }
}
