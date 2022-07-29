//
//  BookMetadataModel.swift
//  GameOfThrones
//
//  Created by Christian Elies on 29/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

struct BookMetadataModel: Decodable {
    let url: URL
    let name: String
}

extension BookMetadataModel: Identifiable {
    var id: URL { url }
}

extension BookMetadataModel: Equatable {}

extension BookMetadataModel: Hashable {}
