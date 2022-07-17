//
//  CharacterDetailState.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import Foundation

struct CharacterDetailState: Equatable {
    let url: URL
    var viewState: ViewState<CharacterDataModel, CharacterClientError> = .loading()
}

extension CharacterDetailState: Identifiable {
    var id: URL { url }
}

extension CharacterDetailState: Hashable {}
