//
//  BookClientError.swift
//  GameOfThrones
//
//  Created by Christian Elies on 29/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

enum BookClientError: Error, Equatable {
    case fetchError(underlying: NSError)
}

extension BookClientError: Hashable {}
