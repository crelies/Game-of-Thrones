//
//  CharacterDetailTests.swift
//  GameOfThronesTests
//
//  Created by Christian Elies on 31/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import ComposableArchitecture
@testable import GameOfThrones
import XCTest

final class CharacterDetailTests: XCTestCase {
    private let scheduler = DispatchQueue.immediate

    private var store: TestStore<CharacterDetailState, CharacterDetailState, CharacterDetailAction, CharacterDetailAction, CharacterDetailEnvironment> {
        TestStore(
            initialState: .init(url: URL(string: "https://christianelies.de")!),
            reducer: CharacterDetailModule.reducer,
            environment: .init(
                mainQueue: { self.scheduler.eraseToAnyScheduler() },
                fetchCharacter: { _ in .none }
            )
        )
    }

    func testOnAppear_ShouldFetchCharacter() {
        // Prepare

        let store = self.store

        let character: CharacterDataModel = .mock()
        store.environment.fetchCharacter = { _ in
            Effect(value: character)
        }

        // Action

        store.send(.onAppear)

        // Validate

        store.receive(.fetchCharacter)

        store.receive(.characterResponse(.success(character))) {
            $0.viewState = .loaded(character)
        }
    }
}
