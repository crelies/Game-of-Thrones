//
//  BookDetailTests.swift
//  GameOfThronesTests
//
//  Created by Christian Elies on 31/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import ComposableArchitecture
@testable import GameOfThrones
import XCTest

final class BookDetailTests: XCTestCase {
    private let scheduler = DispatchQueue.immediate

    private var store: TestStore<BookDetailState, BookDetailState, BookDetailAction, BookDetailAction, BookDetailEnvironment> {
        TestStore(
            initialState: BookDetailState(url: URL(string: "https://christianelies.de")!),
            reducer: BookDetailModule.reducer,
            environment: BookDetailEnvironment(
                mainQueue: { self.scheduler.eraseToAnyScheduler() },
                fetchBook: { _ in .none }
            )
        )
    }

    func testOnAppear_ShouldFetchBook() {
        // Prepare

        let store = self.store

        let book: BookDataModel = .mock()
        store.environment.fetchBook = { _ in
            Effect(value: book)
        }

        // Action

        store.send(.onAppear)

        // Validate

        store.receive(.fetchBook)

        store.receive(.bookResponse(.success(book))) {
            $0.viewState = .loaded(book)
        }
    }
}
