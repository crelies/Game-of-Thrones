//
//  CategoryState.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 16/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

enum CategoryState: Equatable {
    case houses(HouseListState)
    case characters(CharacterListState)
    case books(BookListState)
}
