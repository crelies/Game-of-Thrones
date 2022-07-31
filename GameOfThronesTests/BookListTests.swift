//
//  BookListTests.swift
//  GameOfThronesTests
//
//  Created by Christian Elies on 31/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import ComposableArchitecture
@testable import GameOfThrones
import XCTest

final class BookListTests: XCTestCase {
    private let scheduler = DispatchQueue.immediate

    private var store: TestStore<BookListState, BookListState, BookListAction, BookListAction, BookListEnvironment> {
        TestStore(
            initialState: .init(),
            reducer: BookListModule.reducer,
            environment: .init(
                mainQueue: { self.scheduler.eraseToAnyScheduler() },
                bookClient: .none()
            )
        )
    }
}
