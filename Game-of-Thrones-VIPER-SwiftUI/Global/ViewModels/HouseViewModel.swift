//
//  HouseViewModel.swift
//  Game-of-Thrones-VIPER-SwiftUI
//
//  Created by Christian Elies on 02.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct HouseViewModel {
    let url: URL
    let name: String
}

extension HouseViewModel: Identifiable {
    var id: String { url.absoluteString }
}
