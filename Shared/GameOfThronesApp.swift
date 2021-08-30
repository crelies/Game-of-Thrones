//
//  GameOfThronesApp.swift
//  Shared
//
//  Created by Christian Elies on 22.07.20.
//  Copyright © 2020 Christian Elies. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

let store = Store<HouseListState, HouseListAction>(
    initialState: .init(),
    reducer: HouseListModule.reducer,
    environment: HouseListEnvironment(
        mainQueue: { DispatchQueue.main.eraseToAnyScheduler() },
        fetchHouses: { page, pageSize in
            Effect.task {
                try await APIService().getHouses(page: page, pageSize: pageSize)
                    .compactMap { house -> HouseMetadataModel? in
                        guard let url = house.url else {
                            return nil
                        }
                        guard let name = house.name else {
                            return nil
                        }
                        return HouseMetadataModel(url: url, name: name)
                    }
            }
            .mapError { HouseListError.fetchError(underlying: $0 as NSError) }
            .eraseToEffect()
        }, fetchHouse: { id, url in
            Effect.task {
                let houseResponseModel = try await APIService().getHouse(atURL: url)
                return try houseResponseModel.houseDataModel(id: id)
            }
            .mapError { HouseListError.fetchError(underlying: $0 as NSError) }
            .eraseToEffect()
        }
    )
)

@main
struct GameOfThronesApp: App {
    @State private var selectedNavigationItem: NavigationItem?
    @State private var selectedHouse: HouseDataModel?

    var body: some Scene {
        WindowGroup {
            NavigationView {
                // Sidebar (first column)
                Sidebar(selection: $selectedNavigationItem, selectedHouse: $selectedHouse)
                    .frame(minWidth: 200, minHeight: 700)

                // Primary view (second column)
                PrimaryView(navigationItem: $selectedNavigationItem, selectedHouse: $selectedHouse)
                    .frame(minWidth: 300, minHeight: 700)

                // Detail view (third column)
                Text("Nothing selected")
            }
        }
    }
}
