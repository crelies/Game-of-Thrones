//
//  CharacterListView+State.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import IdentifiedCollections

extension CharacterListView {
    struct State: Equatable {
        let viewState: ViewState<IdentifiedArrayOf<CharacterMetadataModel>, CharacterClientError>
        let selection: CharacterMetadataModel.ID?
    }
}
