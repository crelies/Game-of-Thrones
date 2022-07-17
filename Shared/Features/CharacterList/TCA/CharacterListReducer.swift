//
//  CharacterListReducer.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture

enum CharacterListModule {}

extension CharacterListModule {
    static var reducer: Reducer<CharacterListState, CharacterListAction, CharacterListEnvironment> {
        .init { state, action, environment in
            switch action {
            case .onAppear:
                guard case ViewState.loading = state.viewState else {
                    return .none
                }
                return .init(value: .refresh)

            case .refresh:
                return .init(value: .fetchCharacters)

            case .fetchCharacters:
                return environment.characterClient.fetchCharacters()
                    .receive(on: environment.mainQueue())
                    .catchToEffect(CharacterListAction.charactersResponse)

            case let .charactersResponse(.success(characters)):
                state.viewState = .loaded(.init(uniqueElements: characters))

            case let .charactersResponse(.failure(error)):
                state.viewState = .failure(error)

            case .alertDismissed:
                state.alertState = nil

            default: ()
            }
            return .none
        }
    }
}
