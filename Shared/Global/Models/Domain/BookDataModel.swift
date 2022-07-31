//
//  BookDataModel.swift
//  GameOfThrones
//
//  Created by Christian Elies on 29/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

struct BookDataModel {
    let url: URL
    let name: String
    let isbn: String
    let authors: [String]
    let numberOfPages: Int
    let publisher: String
    let country: String
    let mediaType: String
    // iso8601
    let released: Date?
    // Character URLs
    let characters: [URL]
    // Character URLs
    let povCharacters: [URL]
}

extension BookDataModel: Equatable {}

extension BookDataModel: Hashable {}
