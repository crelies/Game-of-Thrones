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
}
