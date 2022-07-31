//
//  CharacterListView.Action+feature.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

extension CharacterListView.Action {
    var feature: CharacterListAction {
        switch self {
        case .onAppear:
            return .onAppear
        case .refresh:
            return .refresh
        case let .setSelection(selection):
            return .setSelection(selection: selection)
        case .onDisappear:
            return .onDisappear
        }
    }
}
