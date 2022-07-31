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

    func testOnAppear_ShouldFetchBooks() {
        // Prepare

        let store = self.store

        let book: BookMetadataModel = .mock()
        store.environment.bookClient.fetchBooks = { _, _ in
            Effect(value: [book])
        }

        // Action

        store.send(.onAppear)

        // Validate

        store.receive(.refresh)

        store.receive(.fetchBooks)

        store.receive(.booksResponse(.success([book]))) {
            $0.viewState = .loaded(.init(uniqueElements: [book]))
        }
    }

    func testRefresh_ShouldFetchBooks() {
        // Prepare

        let store = self.store

        let book: BookMetadataModel = .mock()
        store.environment.bookClient.fetchBooks = { _, _ in
            Effect(value: [book])
        }

        // Action

        store.send(.refresh)

        // Validate

        store.receive(.fetchBooks)

        store.receive(.booksResponse(.success([book]))) {
            $0.viewState = .loaded(.init(uniqueElements: [book]))
        }
    }

    func testSelectRow_ShouldSetSelection() {
        // Prepare

        let store = self.store

        // Action

        let book: BookMetadataModel = .mock()
        store.send(.setSelection(selection: book.id)) {
            $0.selection = .init(url: book.id)
        }
    }

    func testDeselectRow_ShouldResetSelection() {
        // Prepare

        let store = self.store

        // Action

        let book: BookMetadataModel = .mock()
        store.send(.setSelection(selection: book.id)) {
            $0.selection = .init(url: book.id)
        }

        store.send(.setSelection(selection: nil)) {
            $0.selection = nil
        }
    }
}
