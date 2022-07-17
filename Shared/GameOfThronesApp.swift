//
//  GameOfThronesApp.swift
//  Shared
//
//  Created by Christian Elies on 22.07.20.
//  Copyright © 2020 Christian Elies. All rights reserved.
//

import ComposableArchitecture
import Foundation
import SwiftUI

let dependencies = Dependencies()

let store = Store<AppState, AppAction>(
    initialState: .init(),
    reducer: AppModule.reducer,
    environment: AppEnvironment(
        mainQueue: { DispatchQueue.main.eraseToAnyScheduler() },
        houseClient: .init(
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
            }, fetchHouse: { id, url in
                Effect.task {
                    let houseResponseModel = try await dependencies.apiService.getHouse(atURL: url)
                    return try houseResponseModel.houseDataModel(id: id)
                }
                .mapError { HouseListError.fetchError(underlying: $0 as NSError) }
                .eraseToEffect()
            }
        )
    )
)

@main
struct GameOfThronesApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(store: store)
        }
    }
}
