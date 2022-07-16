//
//  Dependencies.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

struct Dependencies {
    let apiService: APIService

    init() {
        apiService = APIService()
    }
}
