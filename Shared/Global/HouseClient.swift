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
    var fetchHouse: (_ at: URL) -> Effect<HouseDataModel, HouseListError>
}

extension HouseClient {
    static func live() -> Self {
        .init(
            fetchHouses: { page, pageSize in
                Effect.task {
                    try await dependencies.apiService.getHouses(page: page, pageSize: pageSize)
                        .compactMap { house -> HouseMetadataModel? in
                            guard let name = house.name else {
                                return nil
                            }
                            return HouseMetadataModel(url: house.url, name: name)
                        }
                }
                .mapError { HouseListError.fetchError(underlying: $0 as NSError) }
                .eraseToEffect()
            }, fetchHouse: { url in
                Effect.task {
                    let houseResponseModel = try await dependencies.apiService.getHouse(atURL: url)
                    return try houseResponseModel.houseDataModel()
                }
                .mapError { HouseListError.fetchError(underlying: $0 as NSError) }
                .eraseToEffect()
            }
        )
    }
}

#if DEBUG
extension HouseClient {
    static func mock() -> Self {
        .init(
            fetchHouses: { _, _ in .none },
            fetchHouse: { _ in .none }
        )
    }
}
#endif
