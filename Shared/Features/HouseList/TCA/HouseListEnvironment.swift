//
//  HouseListEnvironment.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 29.08.21.
//  Copyright © 2021 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture

struct HouseListEnvironment {
    var mainQueue: () -> AnySchedulerOf<DispatchQueue>
    var houseClient: HouseClient
}
