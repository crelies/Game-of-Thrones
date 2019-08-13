//
//  HouseCadetBranchesView.swift
//  Game-of-Thrones-VIPER-SwiftUI
//
//  Created by Christian Elies on 03.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct HouseCadetBranchesView: View {
    @State private var collapsed: Bool = true
    
    let cadetBranches: [URL]
    
    var body: some View {
        Group {
            HStack {
                if cadetBranches.count > 0 {
                    Button(action: {
                        self.collapsed.toggle()
                    }) {
                        HStack {
                            Image(systemName: collapsed ? "plus" : "minus")
                            Text("\(cadetBranches.count) Cadet branches")
                        }
                    }
                } else {
                    Text("\(cadetBranches.count) Cadet branches")
                }
            }
            
            if !collapsed {
                ForEach(cadetBranches, id: \.self) { cadetBranch in
                    Text(cadetBranch.absoluteString)
                }
            }
        }
    }
}

#if DEBUG
struct HouseCadetBranchesView_Previews: PreviewProvider {
    static var previews: some View {
        HouseCadetBranchesView(cadetBranches: [])
    }
}
#endif
