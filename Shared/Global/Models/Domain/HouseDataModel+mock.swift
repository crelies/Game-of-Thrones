//
//  HouseDataModel+mock.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

#if DEBUG
import Foundation

extension HouseDataModel {
    static func mock() -> Self {
        .init(
            url: URL(string: "https://duckduckgo.com")!,
            name: "Mock House",
            region: "Amsterdam",
            coatOfArms: "-",
            words: "Fire",
            titles: [
                "Awesome"
            ],
            seats: [
                "High Chair"
            ],
            currentLord: URL(string: "https://duckduckgo.com")!,
            heir: URL(string: "https://duckduckgo.com")!,
            overlord: URL(string: "https://duckduckgo.com")!,
            founded: "1990",
            founder: URL(string: "https://duckduckgo.com")!,
            diedOut: "9999",
            ancestralWeapons: [
                "Sword"
            ],
            cadetBranches: [
                URL(string: "https://duckduckgo.com")!,
                URL(string: "https://duckduckgo.com")!,
                URL(string: "https://duckduckgo.com")!
            ],
            swornMembers: [
                URL(string: "https://duckduckgo.com")!,
                URL(string: "https://duckduckgo.com")!,
                URL(string: "https://duckduckgo.com")!
            ]
        )
    }
}
#endif
