//
//  AppView.Action+feature.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 31.08.21.
//  Copyright © 2021 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

extension AppView.Action {
    var feature: AppAction {
        switch self {
        case AppView.Action.onAppear:
            return AppAction.onAppear
        case let AppView.Action.setSelectedNavigationItem(navigationItem):
            return AppAction.setSelectedNavigationItem(navigationItem: navigationItem)
        }
    }
}
