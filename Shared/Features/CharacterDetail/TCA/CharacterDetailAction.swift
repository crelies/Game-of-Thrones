//
//  CharacterDetailAction.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import Foundation

enum CharacterDetailAction: Equatable {
    case onAppear
    case fetchCharacter
    case characterResponse(Result<CharacterDataModel, CharacterClientError>)
    case setSelectedCharacter(url: URL?)
    case setSelectedHouse(url: URL?)
    case setSelectedBook(url: URL?)
}

extension CharacterDetailAction: Hashable {}
