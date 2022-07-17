//
//  CategoryListReducer.swift
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

enum CategoryListModule {}

extension CategoryListModule {
    static var reducer: Reducer<CategoryListState, CategoryListAction, CategoryListEnvironment> {
        .combine(
            CharacterListModule.reducer
                .pullback(
                    state: /CategoryListState.characters,
                    action: /CategoryListAction.characters,
                    environment: {
                        .init(mainQueue: $0.mainQueue)
                    }
                )
            ,
            HouseListModule.reducer
                .pullback(
                    state: /CategoryListState.houseList,
                    action: /CategoryListAction.houseList,
                    environment: {
                        .init(
                            mainQueue: $0.mainQueue,
                            houseClient: $0.houseClient
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
