//
//  HouseDetailTests.swift
//  GameOfThronesTests
//
//  Created by Christian Elies on 31/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import ComposableArchitecture
@testable import GameOfThrones
import XCTest

final class HouseDetailTests: XCTestCase {
    private let scheduler = DispatchQueue.immediate

    private var store: TestStore<HouseDetailState, HouseDetailState, HouseDetailAction, HouseDetailAction, HouseDetailEnvironment> {
        TestStore(
            initialState: .init(url: URL(string: "https://christianelies.de")!),
            reducer: HouseDetailModule.reducer,
            environment: .init(
                mainQueue: { self.scheduler.eraseToAnyScheduler() },
                fetchHouse: { _ in .none },
                fetchCharacter: { _ in .none }
            )
        )
    }
}
