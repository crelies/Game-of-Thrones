//
//  HouseListError.swift
//  Game-of-Thrones-SwiftUI
//
//  Created by Christian Elies on 18.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation

enum HouseListError: Error, Equatable {
    case fetchError(underlying: NSError)
}

extension HouseListError: Hashable {}
