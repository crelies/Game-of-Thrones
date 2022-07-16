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

    var body: some View {
        switch navigationItem {
        case .houses:
            Text("Houses")
        case .characters:
            Text("Characters: Coming soon ...")
        case .books:
            Text("Books: Coming soon ...")
        case .none:
            Text("No category selected")
        }
    }
}

struct PrimaryView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryView(navigationItem: .constant(nil))
    }
}
