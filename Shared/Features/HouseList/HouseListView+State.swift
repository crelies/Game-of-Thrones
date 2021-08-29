//
//  HouseListView+State.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 29.08.21.
//  Copyright © 2021 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture
import Foundation

extension HouseListView {
    struct State: Equatable {
        let isLoading: Bool
        let isInitialLoading: Bool
        var selection: Identified<HouseListRowState.ID, HouseDetailState>?
    }
}
