//
//  BookResponseModel+BookDataModelConvertible.swift
//  GameOfThrones
//
//  Created by Christian Elies on 29/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

extension BookResponseModel: BookDataModelConvertible {
    func bookDataModel() throws -> BookDataModel {
        return .init(
            url: url,
            name: name ?? "",
            isbn: isbn ?? "",
            authors: authors ?? [],
            numberOfPages: numberOfPages ?? 0,
            publisher: publisher ?? "",
            country: country ?? "",
            mediaType: mediaType ?? "",
            released: released,
            characters: characters ?? [],
            povCharacters: povCharacters ?? []
        )
    }
}
