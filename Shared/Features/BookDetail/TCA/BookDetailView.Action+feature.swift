//
//  BookDetailView.Action+feature.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 29/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

extension BookDetailView.Action {
    var feature: BookDetailAction {
        switch self {
        case .onAppear:
            return .onAppear
        case let .setSelectedCharacter(url):
            return .setSelectedCharacter(url: url)
        }
    }
}
