//
//  HouseDetailState.swift
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

struct HouseDetailState: Equatable {
    let id: String
    let url: URL
    var viewState: ViewState<HouseDataModel, HouseListError> = .loading()
}

extension HouseDetailState: Identifiable {}

extension HouseDetailState: Hashable {}