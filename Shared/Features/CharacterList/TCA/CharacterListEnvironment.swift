//
//  CharacterListEnvironment.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture

struct CharacterListEnvironment {
    var mainQueue: () -> AnySchedulerOf<DispatchQueue>
    var characterClient: CharacterClient
}
