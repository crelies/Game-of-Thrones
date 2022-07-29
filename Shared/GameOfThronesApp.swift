//
//  GameOfThronesApp.swift
//  Shared
//
//  Created by Christian Elies on 22.07.20.
//  Copyright © 2020 Christian Elies. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

let dependencies = Dependencies()

let store = Store<AppState, AppAction>(
    initialState: .init(),
    reducer: AppModule.reducer,
    environment: AppEnvironment(
        mainQueue: { DispatchQueue.main.eraseToAnyScheduler() },
        houseClient: .live(),
        characterClient: .live(),
        bookClient: .live()
    )
)

@main
struct GameOfThronesApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(store: store)
        }
    }
}
