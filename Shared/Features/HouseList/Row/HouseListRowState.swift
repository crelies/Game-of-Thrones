//
//  HouseListRowState.swift
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

struct HouseListRowState: Equatable, Identifiable {
    let id: UUID
    let dataModel: HouseMetadataModel
    var isLoading = false
    var alertState: AlertState<HouseListRowAction>?
    var selection: Identified<HouseListRowState.ID, HouseDetailState>?
}
