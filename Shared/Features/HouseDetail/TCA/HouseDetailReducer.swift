//
//  HouseDetailReducer.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 29.08.21.
//  Copyright © 2021 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture

enum HouseDetailModule {}

extension HouseDetailModule {
    static var reducer: Reducer<HouseDetailState, HouseDetailAction, HouseDetailEnvironment> {
        .combine(
            CharacterDetailModule.reducer
                .optional()
                .pullback(
                    state: \.selectedCharacter,
                    action: /HouseDetailAction.characterDetail,
                    environment: {
                        .init(mainQueue: $0.mainQueue, fetchCharacter: $0.fetchCharacter)
                    }
                )
            ,
            .init { state, action, environment in
                switch action {
                case .onAppear:
                    switch state.viewState {
                    case .loaded:
                        return .none
                    default: ()
                    }
                    return .init(value: .fetchHouse)

                case .fetchHouse:
                    state.viewState = .loading()

                    return environment
                        .fetchHouse(state.url)
                        .receive(on: environment.mainQueue())
                        .catchToEffect(HouseDetailAction.houseResponse)

                case let .houseResponse(result):
                    switch result {
                    case let .success(dataModel):
                        state.viewState = .loaded(dataModel)

                    case let .failure(error):
                        state.viewState = .failure(error)
                    }

                case let .setSelectedCharacter(url: .some(url)):
                    state.selectedCharacter = .init(url: url)

                case .setSelectedCharacter(url: .none):
                    state.selectedCharacter = nil

                case .setSelectedCharacterPresented(false):
                    state.selectedCharacter = nil

                case let .characterDetail(.setSelectedCharacter(url: url)):
                    return .init(value: .setSelectedCharacter(url: url))

                default: ()
                }

                return .none
            }
        )
    }
}
