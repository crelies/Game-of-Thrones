//
//  CategorySelection.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import SwiftUI

struct CategorySelection: View {
    @Binding var category: NavigationItem?

    var body: some View {
        List(selection: $category) {
            Label("Houses", systemImage: "house").tag(NavigationItem.houses)
            Label("Characters", systemImage: "person").tag(NavigationItem.characters)
            Label("Books", systemImage: "book").tag(NavigationItem.books)
        }
        .listStyle(.sidebar)
//        .navigationTitle("Categories")
    }
}
