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
            id: UUID().uuidString,
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
            currentLord: nil,
            heir: nil,
            overlord: nil,
            founded: "1990",
            founder: nil,
            diedOut: "9999",
            ancestralWeapons: [],
            cadetBranches: [],
            swornMembers: []
        )
    }
}
#endif
