//
//  CharacterListAction.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

enum CharacterListAction: Equatable {
    case onAppear
    case refresh
    case fetchCharacters
    case charactersResponse(Result<[CharacterMetadataModel], CharacterClientError>)
    case setSelection(selection: CharacterMetadataModel.ID?)
    case alertDismissed
}

extension CharacterListAction: Hashable {}
