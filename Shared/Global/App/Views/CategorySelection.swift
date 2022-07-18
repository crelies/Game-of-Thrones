//
//  CategorySelection.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import SwiftUI

struct CategorySelection: View {
    @Binding var category: Category?

    var body: some View {
        List(selection: $category) {
            Label("Houses", systemImage: "house").tag(Category.houses)
            Label("Characters", systemImage: "person").tag(Category.characters)
            Label("Books", systemImage: "book").tag(Category.books)
        }
        .listStyle(.sidebar)
        .navigationTitle("Categories")
    }
}
