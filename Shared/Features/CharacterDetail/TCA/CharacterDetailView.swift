//
//  CharacterDetailView.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture
import SwiftUI

struct CharacterDetailView: View {
    let store: Store<CharacterDetailState, CharacterDetailAction>

    var body: some View {
        WithViewStore(
            store.scope(
                state: { $0.view },
                action: { (viewAction: CharacterDetailView.Action) in
                    viewAction.feature
                }
            )
        ) { viewStore in
            Text("Character details here ...")
        }
    }
}
