//
//  AppAction.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 31.08.21.
//  Copyright © 2021 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

enum AppAction: Equatable {
    case onAppear
    case setSelectedCategory(category: Category?)
    case categoryList(CategoryListAction)
    case houseDetail(HouseDetailAction)
    case characterDetail(CharacterDetailAction)
    case bookDetail(BookDetailAction)
}
