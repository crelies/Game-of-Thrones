//
//  HouseAncestralWeaponsView.swift
//  Game-of-Thrones-VIPER-SwiftUI
//
//  Created by Christian Elies on 03.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct HouseAncestralWeaponsView: View {
    @State private var collapsed: Bool = true
    
    let ancestralWeapons: [String]
    
    var body: some View {
        Group {
            HStack {
                if ancestralWeapons.count > 0 {
                    Button(action: {
                        self.collapsed.toggle()
                    }) {
                        HStack {
                            Image(systemName: collapsed ? "plus" : "minus")
                            Text("\(ancestralWeapons.count) Ancestral weapons")
                        }
                    }
                } else {
                    Text("\(ancestralWeapons.count) Ancestral weapons")
                }
            }
            
            if !collapsed {
                ForEach(ancestralWeapons, id: \.self) { ancestralWeapon in
                    Text(ancestralWeapon)
                }
            }
        }
    }
}

#if DEBUG
struct HouseAncestralWeaponsView_Previews: PreviewProvider {
    static var previews: some View {
        HouseAncestralWeaponsView(ancestralWeapons: [])
    }
}
#endif
