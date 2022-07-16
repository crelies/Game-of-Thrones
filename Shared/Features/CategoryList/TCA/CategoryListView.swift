//
//  CategoryListView.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 16/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture
import SwiftUI

struct CategoryListView: View {
    let store: Store<CategoryListState, CategoryListAction>

    var body: some View {
        SwitchStore(store) {
            CaseLet(state: /CategoryListState.houseList, action: CategoryListAction.houseList) { houseListStore in
                HouseListView(store: houseListStore)
            }

            Default {
                Text("Not implemented")
            }
        }
    }
}
