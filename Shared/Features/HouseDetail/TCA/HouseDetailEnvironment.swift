//
//  HouseDetailEnvironment.swift
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

struct HouseDetailEnvironment {
    var mainQueue: () -> AnySchedulerOf<DispatchQueue>
    var fetchHouse: (_ url: URL) -> Effect<HouseDataModel, HouseListError>
    var fetchCharacter: (URL) -> Effect<CharacterDataModel, CharacterClientError>
}
