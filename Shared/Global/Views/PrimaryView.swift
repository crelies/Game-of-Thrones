//
//  PrimaryView.swift
//  Game-of-Thrones-SwiftUI
//
//  Created by Christian Elies on 22.07.20.
//  Copyright © 2020 Christian Elies. All rights reserved.
//

import SwiftUI

struct PrimaryView: View {
    @Binding var navigationItem: NavigationItem?
    @Binding var selectedHouse: HouseMetadataModel?

    var body: some View {
        switch navigationItem {
        case .houses:
            HouseListScreen(selectedHouse: $selectedHouse)
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

#if DEBUG
struct PrimaryView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryView(navigationItem: .constant(nil), selectedHouse: .constant(nil))
    }
}
#endif
