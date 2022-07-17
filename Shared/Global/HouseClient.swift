//
//  HouseClient.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import ComposableArchitecture
import Foundation

struct HouseClient {
    var fetchHouses: (_ page: Int, _ pageSize: Int) -> Effect<[HouseMetadataModel], HouseListError>
    var fetchHouse: (_ id: String, _ at: URL) -> Effect<HouseDataModel, HouseListError>
}

#if DEBUG
extension HouseClient {
    static func mock() -> Self {
        .init(
            fetchHouses: { _, _ in .none },
            fetchHouse: { _, _ in .none }
        )
    }
}
#endif
