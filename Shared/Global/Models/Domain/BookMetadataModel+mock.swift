//
//  BookMetadataModel+mock.swift
//  GameOfThronesTests
//
//  Created by Christian Elies on 31/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

#if DEBUG
import Foundation

extension BookMetadataModel {
    static func mock() -> Self {
        .init(
            url: URL(string: "https://christianelies.de")!,
            name: "A book of Ice and Fire"
        )
    }
}
#endif
