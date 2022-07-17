//
//  CategoryListState.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 16/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

enum CategoryListState: Equatable {
    case houseList(HouseListState)
    case characters(CharacterListState)
    case books
}
