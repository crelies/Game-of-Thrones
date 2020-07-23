//
//  NavigationPrimary.swift
//  Game-of-Thrones-VIPER-SwiftUI
//
//  Created by Christian Elies on 22.07.20.
//  Copyright © 2020 Christian Elies. All rights reserved.
//

import SwiftUI

struct NavigationPrimary: View {
    @EnvironmentObject private var houseListViewModel: HouseListViewModel

    @Binding var navigationItem: NavigationItem?
    @Binding var selectedHouse: HouseMetadataModel?

    var body: some View {
        Group {
            switch navigationItem {
            case .houses:
                HouseListScreen(viewModel: houseListViewModel, selectedHouse: $selectedHouse)
            case .characters:
                Text("Characters: coming soon ...")
                    .onAppear {
                        selectedHouse = nil
                    }
            case .books:
                Text("Books: coming soon ...")
                    .onAppear {
                        selectedHouse = nil
                    }
            case .none:
                Text("None")
                    .onAppear {
                        selectedHouse = nil
                    }
            }
        }
    }
}

struct NavigationPrimary_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPrimary(navigationItem: .constant(nil), selectedHouse: .constant(nil))
    }
}
