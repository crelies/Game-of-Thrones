//
//  GameOfThronesApp.swift
//  Shared
//
//  Created by Christian Elies on 22.07.20.
//  Copyright © 2020 Christian Elies. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

let store = Store<AppState, AppAction>(
    initialState: .init(),
    reducer: AppModule.reducer,
    environment: AppEnvironment()
)

@main
struct GameOfThronesApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(store: store)
        }
    }
}
