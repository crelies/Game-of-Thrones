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
    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
}

extension DefaultAPIService: APIService {
    func getHouses(page: Int, pageSize: Int) async throws -> [HouseResponseModel] {
        let queryItemPage = URLQueryItem(name: "page", value: "\(page)")
        let queryItemPageSize = URLQueryItem(name: "pageSize", value: "\(pageSize)")

        var urlComponents = URLComponents(
            url: housesURL,
            resolvingAgainstBaseURL: false
        )
        urlComponents?.queryItems = [queryItemPage, queryItemPageSize]

        guard let url = urlComponents?.url else {
            throw APIServiceError.couldNotCreateURL
        }

        let housesUrlRequest = URLRequest(url: url)
        let (data, _) = try await urlSession.data(for: housesUrlRequest)
        return try jsonDecoder.decode([HouseResponseModel].self, from: data)
    }

    func getHouse(atURL url: URL) async throws -> HouseResponseModel {
        let houseURLRequest = URLRequest(url: url)
        let (data, _) = try await urlSession.data(for: houseURLRequest)
        return try jsonDecoder.decode(HouseResponseModel.self, from: data)
    }
}
