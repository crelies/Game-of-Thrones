//
//  BookDataModel+mock.swift
//  GameOfThrones
//
//  Created by Christian Elies on 31/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

#if DEBUG
import Foundation

extension BookDataModel {
    static func mock() -> Self {
        .init(
            url: URL(string: "https://christianelies.de")!,
            name: "A story of Ice and Fire",
            isbn: "56856945864568023",
            authors: [
                "John Powell"
            ],
            numberOfPages: 0,
            publisher: "Netflix",
            country: "Netherlands",
            mediaType: "Movie",
            released: Date().addingTimeInterval(-36000000),
            characters: [
                URL(string: "https://christianelies.de")!
            ],
            povCharacters: [
                URL(string: "https://christianelies.de")!
            ]
        )
    }
}
#endif
