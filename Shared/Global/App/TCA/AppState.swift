//
//  AppState.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 31.08.21.
//  Copyright © 2021 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture

struct AppState: Equatable {
    var category: Category?
    var categoryList: CategoryListState?
    var selectedHouse: HouseDetailState?
    var selectedCharacter: CharacterDetailState?
    var selectedBook: BookDetailState?
}
