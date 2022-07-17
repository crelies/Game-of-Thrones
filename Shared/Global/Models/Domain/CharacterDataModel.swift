//
//  CharacterDataModel.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

struct CharacterDataModel {
    let id: String
    let url: URL
    let name: String
    let gender: String
    let culture: String
    let born: String
    let died: String
    let titles: [String]
    let aliases: [String]
    // character
    let father: URL?
    // character
    let mother: URL?
    // character
    let spouse: URL?
    // house URLs
    let allegiances: [URL]
    let books: [URL]
    // book URLs
    let povBooks: [URL]
    let tvSeries: [String]
    let playedBy: [String]
}

extension CharacterDataModel: Identifiable {}

extension CharacterDataModel: Equatable {}

extension CharacterDataModel: Hashable {}
