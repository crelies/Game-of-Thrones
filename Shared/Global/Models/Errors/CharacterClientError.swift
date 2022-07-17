//
//  CharacterClientError.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

enum CharacterClientError: Error, Equatable {
    case fetchError(underlying: NSError)
}

extension CharacterClientError: Hashable {}
