//
//  CharacterListTests.swift
//  GameOfThronesTests
//
//  Created by Christian Elies on 31/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import ComposableArchitecture
@testable import GameOfThrones
import XCTest

final class CharacterListTests: XCTestCase {
    private let scheduler = DispatchQueue.immediate

    private var store: TestStore<CharacterListState, CharacterListState, CharacterListAction, CharacterListAction, CharacterListEnvironment> {
        TestStore(
            initialState: .init(),
            reducer: CharacterListModule.reducer,
            environment: .init(
                mainQueue: { self.scheduler.eraseToAnyScheduler() },
                characterClient: .none()
            )
        )
    }

    func testOnAppear_ShouldFetchCharacters() {
        // Prepare

        let store = self.store

        let character: CharacterMetadataModel = .mock()
        store.environment.characterClient.fetchCharacters = { _, _ in
            Effect(value: [character])
        }

        // Action

        store.send(.onAppear)

        // Validate

        store.receive(.refresh)

        store.receive(.fetchCharacters)

        store.receive(.charactersResponse(.success([character]))) {
            $0.viewState = .loaded(.init(uniqueElements: [character]))
        }
    }

    func testRefresh_ShouldFetchCharacters() {
        // Prepare

        let store = self.store

        let character: CharacterMetadataModel = .mock()
        store.environment.characterClient.fetchCharacters = { _, _ in
            Effect(value: [character])
        }

        // Action

        store.send(.refresh)

        // Validate

        store.receive(.fetchCharacters)

        store.receive(.charactersResponse(.success([character]))) {
            $0.viewState = .loaded(.init(uniqueElements: [character]))
        }
    }

    func testSelectRow_ShouldSetSelection() {
        // Prepare

        let store = self.store

        let character: CharacterMetadataModel = .mock()
        store.send(.charactersResponse(.success([character]))) {
            $0.viewState = .loaded(.init(uniqueElements: [character]))
        }

        // Action

        store.send(.setSelection(selection: character.id)) {
            $0.selection = .init(url: character.id)
        }
    }

    func testDeselectRow_ShouldResetSelection() {
        // Prepare

        let store = self.store

        let character: CharacterMetadataModel = .mock()
        store.send(.charactersResponse(.success([character]))) {
            $0.viewState = .loaded(.init(uniqueElements: [character]))
        }

        // Action

        store.send(.setSelection(selection: character.id)) {
            $0.selection = .init(url: character.id)
        }

        store.send(.setSelection(selection: nil)) {
            $0.selection = nil
        }
    }
}
