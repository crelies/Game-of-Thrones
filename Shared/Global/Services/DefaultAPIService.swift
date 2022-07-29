//
//  DefaultAPIService.swift
//  Game-of-Thrones-SwiftUI
//
//  Created by Christian Elies on 01.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Combine
import Foundation

final class DefaultAPIService {
    private let urlSession: URLSession = .shared
    private let baseURL = URL(string: "https://www.anapioficeandfire.com/api")!
    private lazy var housesURL: URL = {
        return baseURL.appendingPathComponent("/houses")
    }()
    private lazy var charactersURL: URL = {
        return baseURL.appendingPathComponent("/characters")
    }()
    private lazy var booksURL: URL = {
        return baseURL.appendingPathComponent("/books")
    }()
    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
}

extension DefaultAPIService: HousesAPIService {
    func getHouses(page: Int, pageSize: Int) async throws -> [HouseResponseModel] {
        let url = try url(withPage: page, pageSize: pageSize, url: housesURL)
        return try await requestModel(atURL: url)
    }

    func getHouse(atURL url: URL) async throws -> HouseResponseModel {
        try await requestModel(atURL: url)
    }
}

extension DefaultAPIService: CharactersAPIService {
    func getCharacters(page: Int, pageSize: Int) async throws -> [CharacterResponseModel] {
        let url = try url(withPage: page, pageSize: pageSize, url: charactersURL)
        return try await requestModel(atURL: url)
    }

    func getCharacter(atURL url: URL) async throws -> CharacterResponseModel {
        try await requestModel(atURL: url)
    }
}

extension DefaultAPIService: BooksAPIService {
    func getBooks(page: Int, pageSize: Int) async throws -> [BookResponseModel] {
        let url = try url(withPage: page, pageSize: pageSize, url: booksURL)
        return try await requestModel(atURL: url)
    }

    func getBook(atURL url: URL) async throws -> BookResponseModel {
        try await requestModel(atURL: url)
    }
}

private extension DefaultAPIService {
    func url(withPage page: Int, pageSize: Int, url: URL) throws -> URL {
        let queryItemPage = URLQueryItem(name: "page", value: "\(page)")
        let queryItemPageSize = URLQueryItem(name: "pageSize", value: "\(pageSize)")

        var urlComponents = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        )
        urlComponents?.queryItems = [queryItemPage, queryItemPageSize]

        guard let url = urlComponents?.url else {
            throw APIServiceError.couldNotCreateURL
        }

        return url
    }

    func requestModel<T: Decodable>(atURL url: URL) async throws -> T {
        let urlRequest = URLRequest(url: url)
        let (data, _) = try await urlSession.data(for: urlRequest)
        return try jsonDecoder.decode(T.self, from: data)
    }
}
