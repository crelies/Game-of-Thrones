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
    enum Endpoint: String, CaseIterable {
        case houses
        case characters
        case books
    }

    private static var customDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()

    private let urlSession: URLSession = .shared
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Self.customDateFormatter)
        return decoder
    }()
    private let api = API(
        baseURL: URL(string: "https://www.anapioficeandfire.com/api")!,
        endpoints: Endpoint.allCases
    )
}

extension DefaultAPIService: HousesAPIService {
    func getHouses(page: Int, pageSize: Int) async throws -> [HouseResponseModel] {
        let url = try url(withPage: page, pageSize: pageSize, url: api.url(for: .houses))
        return try await requestModel(atURL: url)
    }

    func getHouse(atURL url: URL) async throws -> HouseResponseModel {
        try await requestModel(atURL: url)
    }
}

extension DefaultAPIService: CharactersAPIService {
    func getCharacters(page: Int, pageSize: Int) async throws -> [CharacterResponseModel] {
        let url = try url(withPage: page, pageSize: pageSize, url: api.url(for: .characters))
        return try await requestModel(atURL: url)
    }

    func getCharacter(atURL url: URL) async throws -> CharacterResponseModel {
        try await requestModel(atURL: url)
    }
}

extension DefaultAPIService: BooksAPIService {
    func getBooks(page: Int, pageSize: Int) async throws -> [BookResponseModel] {
        let url = try url(withPage: page, pageSize: pageSize, url: api.url(for: .books))
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
