//
//  ContentView.swift
//  Game-of-Thrones-VIPER-SwiftUI
//
//  Created by Christian Elies on 13.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HouseListView()
            .tabItem {
                VStack {
                    Image(systemName: "list.bullet")
                    Text("Houses")
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
