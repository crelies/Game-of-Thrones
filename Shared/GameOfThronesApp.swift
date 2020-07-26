//
//  GameOfThronesApp.swift
//  Shared
//
//  Created by Christian Elies on 22.07.20.
//  Copyright © 2020 Christian Elies. All rights reserved.
//

import SwiftUI

@main
struct GameOfThronesApp: App {
    @State private var selectedNavigationItem: NavigationItem?
    @State private var selectedHouse: HouseMetadataModel?

    var body: some Scene {
        WindowGroup {
            NavigationView {
                Sidebar(selection: $selectedNavigationItem, selectedHouse: $selectedHouse)
                    .frame(minWidth: 200, minHeight: 700)

                PrimaryView(navigationItem: $selectedNavigationItem, selectedHouse: $selectedHouse)
                    .frame(minWidth: 300, minHeight: 700)

                if let selectedHouse = selectedHouse {
                    HouseDetailScreen(url: selectedHouse.url)
                        .frame(minWidth: 400, minHeight: 700)
                }
            }
        }
    }
}
