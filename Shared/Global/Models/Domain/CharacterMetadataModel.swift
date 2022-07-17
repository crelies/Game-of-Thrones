//
//  CharacterMetadataModel.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

struct CharacterMetadataModel: Decodable {
    let url: URL
    let name: String
}

extension CharacterMetadataModel: Identifiable {
    var id: URL { url }
}

extension CharacterMetadataModel: Equatable {}

extension CharacterMetadataModel: Hashable {}
