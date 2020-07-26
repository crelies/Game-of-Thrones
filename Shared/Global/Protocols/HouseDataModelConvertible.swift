//
//  HouseDataModelConvertible.swift
//  Game-of-Thrones-SwiftUI
//
//  Created by Christian Elies on 02.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation

protocol HouseDataModelConvertible {
    func houseDataModel() throws -> HouseDataModel
}
