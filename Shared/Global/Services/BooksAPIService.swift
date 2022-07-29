//
//  BooksAPIService.swift
//  GameOfThrones
//
//  Created by Christian Elies on 29/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

protocol BooksAPIService {
    func getBooks(page: Int, pageSize: Int) async throws -> [BookResponseModel]
    func getBook(atURL url: URL) async throws -> BookResponseModel
}
