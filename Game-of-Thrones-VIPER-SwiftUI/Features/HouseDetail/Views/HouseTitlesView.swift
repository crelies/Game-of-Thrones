//
//  HouseTitlesView.swift
//  Game-of-Thrones-VIPER-SwiftUI
//
//  Created by Christian Elies on 03.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct HouseTitlesView: View {
    @State private var collapsed: Bool = true
    
    let titles: [String]
    
    var body: some View {
        Group {
            HStack {
                if titles.count > 0 {
                    Button(action: {
                        self.collapsed.toggle()
                    }) {
                        HStack {
                            Image(systemName: collapsed ? "plus" : "minus")
                            Text("\(titles.count) Titles")
                        }
                    }
                } else {
                    Text("\(titles.count) Titles")
                }
            }
            
            if !collapsed {
                ForEach(titles, id: \.self) { title in
                    Text(title)
                }
            }
        }
    }
}

#if DEBUG
struct HouseTitlesView_Previews: PreviewProvider {
    static var previews: some View {
        HouseTitlesView(titles: [])
    }
}
#endif
