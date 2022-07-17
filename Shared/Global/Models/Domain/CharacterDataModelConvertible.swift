//
//  CharacterDataModelConvertible.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

protocol CharacterDataModelConvertible {
    func characterDataModel(id: String) throws -> CharacterDataModel
}
