//
//  APIService.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

protocol APIServiceProvider {
    var apiService: APIService { get }
}

protocol APIService {
    func getHouses(page: Int, pageSize: Int) async throws -> [HouseResponseModel]
    func getHouse(atURL url: URL) async throws -> HouseResponseModel
}
