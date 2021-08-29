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
    @Binding var selectedHouse: HouseDataModel?

    var body: some View {
        switch navigationItem {
        case .houses:
            HouseListView(store: store)
        case .characters:
            Text("Characters: Coming soon ...")
                .onAppear {
                    selectedHouse = nil
                }
        case .books:
            Text("Books: Coming soon ...")
                .onAppear {
                    selectedHouse = nil
                }
        case .none:
            Text("No category selected")
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
