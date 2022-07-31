//
//  CharacterMetadataModel+mock.swift
//  GameOfThronesTests
//
//  Created by Christian Elies on 31/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

#if DEBUG
import Foundation

extension CharacterMetadataModel {
    static func mock() -> Self {
        .init(
            url: URL(string: "https://christianelies.de")!,
            name: "Matt Damon"
        )
    }
}
#endif
