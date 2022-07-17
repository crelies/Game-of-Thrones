//
//  CharacterResponseModel.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

struct CharacterResponseModel: Decodable {
    let url: URL
    let name: String?
    let gender: String?
    let culture: String?
    let born: String?
    let died: String?
    let titles: [String]?
    let aliases: [String]?
    // character URL
    let father: String?
    // character URL
    let mother: String?
    // character URL
    let spouse: String?
    // house URLs
    let allegiances: [URL]?
    let books: [URL]?
    // book URLs
    let povBooks: [URL]?
    let tvSeries: [String]?
    let playedBy: [String]?
}
