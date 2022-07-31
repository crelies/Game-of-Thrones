//
//  HouseListView.Action+feature.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 29.08.21.
//  Copyright © 2021 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

extension HouseListView.Action {
    var feature: HouseListAction {
        switch self {
        case .onAppear:
            return .onAppear
        case let .setSelection(selection):
            return .setSelection(selection: selection)
        case .refresh:
            return .refresh
        case .onDisappear:
            return .onDisappear
        }
    }
}
