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
            APIService()
                .getHouses(page: page, pageSize: pageSize)
                .mapError { _ in HouseListViewModelError.allHousesLoaded }
                .map { houses -> [HouseMetadataModel] in
                    houses.compactMap { house in
                        guard let url = house.url else {
                            return nil
                        }
                        guard let name = house.name else {
                            return nil
                        }
                        return HouseMetadataModel(url: url, name: name)
                    }
                }
                .eraseToEffect()
        }, fetchHouse: { id, url in
            APIService()
                .getHouse(atURL: url)
                .tryMap { try $0.houseDataModel(id: id) }
                .mapError { _ in HouseListViewModelError.allHousesLoaded }
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
                Sidebar(selection: $selectedNavigationItem, selectedHouse: $selectedHouse)
                    .frame(minWidth: 200, minHeight: 700)

                PrimaryView(navigationItem: $selectedNavigationItem, selectedHouse: $selectedHouse)
                    .frame(minWidth: 300, minHeight: 700)

                #if os(macOS)
                DetailView(navigationItem: $selectedNavigationItem, selectedHouse: $selectedHouse)
                #else
                Text("Nothing selected")
                #endif
            }
        }
    }
}
