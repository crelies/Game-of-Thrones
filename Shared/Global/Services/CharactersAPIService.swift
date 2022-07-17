//
//  CharactersAPIService.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

protocol CharactersAPIService {
    func getCharacters(page: Int, pageSize: Int) async throws -> [CharacterResponseModel]
    func getCharacter(atURL url: URL) async throws -> CharacterResponseModel
}
