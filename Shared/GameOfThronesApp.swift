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
    @StateObject private var houseListViewModel = HouseListViewModel()
    @StateObject private var houseDetailViewModel = HouseDetailViewModel()
    @State private var selectedNavigationItem: NavigationItem?
    @State private var selectedHouse: HouseMetadataModel?

    var body: some Scene {
        WindowGroup {
            NavigationView {
                Sidebar(selection: $selectedNavigationItem)
                    .frame(minWidth: 200, minHeight: 700)

                NavigationPrimary(navigationItem: $selectedNavigationItem, selectedHouse: $selectedHouse)
                    .environmentObject(houseListViewModel)
                    .frame(minWidth: 300, minHeight: 700)


                #if os(macOS)
                if let selectedHouse = selectedHouse {
                    HouseDetailScreen(viewModel: houseDetailViewModel, url: selectedHouse.url)
                        .frame(minWidth: 400, minHeight: 700)
                }
                #endif
            }
        }
    }
}
