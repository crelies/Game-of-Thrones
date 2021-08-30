//
//  Sidebar.swift
//  Game-of-Thrones-SwiftUI
//
//  Created by Christian Elies on 22.07.20.
//  Copyright © 2020 Christian Elies. All rights reserved.
//

import SwiftUI

struct Sidebar: View {
    @Binding var selection: NavigationItem?

    var body: some View {
        List(selection: $selection) {
            NavigationLink(destination: HouseListView(store: store)) {
                Label("Houses", systemImage: "house")
            }
            Label("Characters", systemImage: "person").tag(NavigationItem.characters)
            Label("Books", systemImage: "book").tag(NavigationItem.books)
        }
        .listStyle(.sidebar)
        .navigationTitle("Overview")
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(selection: .constant(nil))
    }
}
