//
//  CharacterListState.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture
import IdentifiedCollections

struct CharacterListState: Equatable {
    var page: Int = 1
    var pageSize: Int = 50
    var viewState: ViewState<IdentifiedArrayOf<CharacterMetadataModel>, CharacterClientError> = .loading()
    var selection: CharacterDetailState?
    var alertState: AlertState<CharacterListAction>?
}

extension CharacterListState: Hashable {}
