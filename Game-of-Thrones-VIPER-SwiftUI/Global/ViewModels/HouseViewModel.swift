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
    var id: String {
        return url.absoluteString
    }
}

extension HouseViewModel: View {
    var body: some View {
        #if !targetEnvironment(macCatalyst)
            let destination = HouseDetailView(url: url)
        #else
            let destination = HouseDetailView(url: url).environmentObject(HouseDetailWireframe.makePresenter())
        #endif
        
        return NavigationLink(destination: destination) {
            Text(name)
        }
    }
}
