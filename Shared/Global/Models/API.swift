//
//  API.swift
//  GameOfThrones
//
//  Created by Christian Elies on 29/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

struct API<Endpoint: RawRepresentable> where Endpoint.RawValue == String {
    let baseURL: URL
    let endpoints: [Endpoint]
}

extension API {
    func url(for endpoint: Endpoint) -> URL {
        let suffix = "/\(endpoint)"
        return baseURL.appendingPathComponent(suffix)
    }
}
