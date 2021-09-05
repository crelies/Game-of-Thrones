//
//  HouseListAction.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 29.08.21.
//  Copyright © 2021 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import Foundation

enum HouseListAction: Equatable {
    case onAppear
    case refresh
    case fetchHouses
    case housesResponse(Result<[HouseMetadataModel], HouseListError>)
    case fetchNextHouses
    case nextHousesResponse(Result<[HouseMetadataModel], HouseListError>)
    case row(index: UUID, action: HouseListRowAction)
    case setSelection(selection: UUID?)
    case presentAlert(error: HouseListError)
    case alertDismissed
}
