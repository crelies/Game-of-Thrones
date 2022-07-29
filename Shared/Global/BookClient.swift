//
//  BookClient.swift
//  GameOfThrones
//
//  Created by Christian Elies on 29/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import ComposableArchitecture

struct BookClient {
    var fetchBooks: (_ page: Int, _ pageSize: Int) -> Effect<[BookMetadataModel], BookClientError>
    var fetchBook: (URL) -> Effect<BookDataModel, BookClientError>
}

extension BookClient {
    static func live() -> Self {
        .init(
            fetchBooks: { page, pageSize in
                Effect.task {
                    try await dependencies.apiService.getBooks(
                        page: page,
                        pageSize: pageSize
                    )
                    .map { BookMetadataModel(url: $0.url, name: $0.name ?? "") }
                }
                .mapError { BookClientError.fetchError(underlying: $0 as NSError) }
                .eraseToEffect()
            },
            fetchBook: { url in
                Effect.task {
                    try await dependencies.apiService.getBook(atURL: url).bookDataModel()
                }
                .mapError { BookClientError.fetchError(underlying: $0 as NSError) }
                .eraseToEffect()
            }
        )
    }
}
