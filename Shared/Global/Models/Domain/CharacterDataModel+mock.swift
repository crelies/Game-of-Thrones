//
//  CharacterDataModel+mock.swift
//  GameOfThrones
//
//  Created by Christian Elies on 18/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

extension CharacterDataModel {
    static func mock() -> Self {
        .init(
            id: UUID().uuidString,
            url: URL(string: "https://gettr.com")!,
            name: "Ragnaros",
            gender: "male",
            culture: "Human",
            born: "359 BC",
            died: "359 AC",
            titles: [
                "King"
            ],
            aliases: [
                "Elias"
            ],
            father: URL(string: "https://gettr.com")!,
            mother: URL(string: "https://gettr.com")!,
            spouse: URL(string: "https://gettr.com")!,
            allegiances: [
                URL(string: "https://gettr.com")!
            ],
            books: [
                URL(string: "https://gettr.com")!
            ],
            povBooks: [
                URL(string: "https://gettr.com")!
            ],
            tvSeries: [
                "Season 1"
            ],
            playedBy: [
                "Matt Damon"
            ]
        )
    }
}
