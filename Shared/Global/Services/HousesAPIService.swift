//
//  HousesAPIService.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

protocol HousesAPIService {
    func getHouses(page: Int, pageSize: Int) async throws -> [HouseResponseModel]
    func getHouse(atURL url: URL) async throws -> HouseResponseModel
}
